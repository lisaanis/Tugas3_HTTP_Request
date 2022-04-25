import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugas3_httprequest/countries_model.dart';
import 'package:tugas3_httprequest/covid_data_source.dart';

class PageDetailCountries extends StatefulWidget {
  const PageDetailCountries({Key? key}) : super(key: key);

  @override
  _PageDetailCountriesState createState() => _PageDetailCountriesState();
}

class _PageDetailCountriesState extends State<PageDetailCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries Detail"),
      ),
      body:  _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
            CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildEmptySection() {
    return const Text("Empty");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CountriesModel data) {
    return ListView.builder(
        itemCount: data.countries?.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: _buildItemCountries('${data.countries?[index].name}',),
                    subtitle: _buildItemCountries('${data.countries?[index].iso3}'),
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lime, width: 2),
                    ),
                  ),
                ],
              )
          );
        });
    }

  Widget _buildItemCountries(String value) {
    return Text(value,
        style: TextStyle(fontWeight: FontWeight.bold));
  }
}