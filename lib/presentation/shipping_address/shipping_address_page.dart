import 'package:fic9_ecommerce_template_app/common/components/button.dart';
import 'package:fic9_ecommerce_template_app/common/components/spaces.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/presentation/shipping_address/add_address_page.dart';
import 'package:fic9_ecommerce_template_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shipping_address/models/address_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/shipping_address/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  // final ValueNotifier<int> selectedIndex = ValueNotifier(1);
  final List<AddressModel> addresses = [
    AddressModel(
      name: 'Abdul Rozak',
      address: 'Jl. suka cita, no 17. kelurahan sukses maju',
      phoneNumber: '08566688686868',
    ),
    AddressModel(
      name: 'Abdul Manaf',
      address: 'Jalan lorem ipsum situ',
      phoneNumber: '08565658888976',
    ),
  ];

  int? idAddress;

  @override
  void initState() {
    context.read<GetAddressBloc>().add(const GetAddressEvent.getAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengiriman'),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAddressPage()),
              );
              // refresh Address
              context
                  .read<GetAddressBloc>()
                  .add(const GetAddressEvent.getAddress());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<GetAddressBloc, GetAddressState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text('No Data'),
              );
            },
            loaded: (data) {
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                separatorBuilder: (context, index) => const SpaceHeight(16.0),
                itemCount: data.data.length,
                itemBuilder: (context, index) => AddressTile(
                  isSelected: idAddress == data.data[index].id,
                  data: data.data[index],
                  onTap: () {
                    idAddress = data.data[index].id;
                    setState(() {});
                  },
                  onEditTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditAddressPage(
                    //       data: addresses[index],
                    //     ),
                    //   ),
                    // );
                  },
                  onDeleteTap: () async {
                    idAddress = data.data[index].id;
                    final result = await OrderRemoteDataSouce()
                        .deleteAddressById(idAddress!);
                    result.fold(
                      (l) => const SnackBar(
                        content: Text('Hapus Alamat gagal'),
                      ),
                      (r) => context
                          .read<GetAddressBloc>()
                          .add(const GetAddressEvent.getAddress()),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Button.filled(
          disabled: idAddress == null,
          onPressed: () {
            Navigator.pop(context, idAddress);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const OrderDetailPage()),
            // );
          },
          label: 'Pilih',
        ),
      ),
    );
  }
}
