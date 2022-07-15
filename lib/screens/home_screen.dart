import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../db/db_helper.dart';
import '../models/block.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  List<Map<String, dynamic>> _blocks = [];
  bool _isSingle = true;
  int _currentValue = 2;
  String _row = '';
  String _model = 'Tunggal';

  void _refreshBlocks() async {
    final data = await SQLHelper.getBlocks();
    setState(() {
      _blocks = data;
    });
  }

  List<Block> blockList = [
    Block(name: 'A21'),
    Block(name: 'A22'),
    Block(name: 'A23'),
    Block(name: 'A24')
  ];

  @override
  void initState() {
    super.initState();
    _refreshBlocks(); // Loading the block when the app starts
  }

  void _addBlock(BuildContext context){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext mContext, StateSetter state){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pilih Block", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,)),
                            IconButton(
                                icon:Icon(Icons.close, size: 32),
                                onPressed: (){
                                  Navigator.pop(mContext);}),
                          ],
                        ),
                        Text("Langkah 1 dari 2", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green, fontSize: 12,))
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(itemCount: blockList.length ,itemBuilder: (context, index) {
                        var block = blockList[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 4, left: 16, right: 16),
                          child: Card(
                            child: ListTile(
                              title: Text('Block: '+block.name!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                              trailing:Icon(Icons.navigate_next, size: 32),
                              onTap: (){
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                    ),
                                    builder: (context){
                                      return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter state){
                                            return Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Pilih Baris" , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,)),
                                                            IconButton(
                                                                icon:Icon(Icons.close, size: 32),
                                                                onPressed: (){
                                                                  Navigator.pop(context);}),
                                                          ],
                                                        ),
                                                        Text("Langkah 2 dari 2", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green, fontSize: 12,)),
                                                        SizedBox(
                                                          height: 24,
                                                        ),
                                                        Text("Model Pemeriksaan", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 12,)),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Center(
                                                          child:ToggleSwitch(
                                                            minWidth: 180,
                                                            minHeight: 40,
                                                            cornerRadius: 5.0,
                                                            activeBgColors: [[Colors.green[800]!], [Colors.green[800]!]],
                                                            activeFgColor: Colors.white,
                                                            inactiveBgColor: Colors.white,
                                                            inactiveFgColor: Colors.green,
                                                            borderColor: [Colors.green[100]!],
                                                            initialLabelIndex: 0,
                                                            totalSwitches: 2,
                                                            labels: ['Tunggal', 'Kanan Kiri'],
                                                            radiusStyle: true,
                                                            onToggle: (index) {
                                                              if(index == 1){
                                                                setState(() {
                                                                  _isSingle = false;
                                                                  _model = "Kanan Kiri";
                                                                });
                                                              }else{
                                                                setState(() {
                                                                  _isSingle = true;
                                                                  _model = "Tunggal";
                                                                });
                                                              }
                                                              print('switched to: $index');
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text("Nomor Baris", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 12,)),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Center(
                                                          child: NumberPicker(
                                                            value: _currentValue,
                                                            minValue: 1,
                                                            maxValue: 100,
                                                            axis: Axis.horizontal,
                                                            onChanged: (newValue) {
                                                              state((){
                                                                _currentValue = newValue;
                                                              });
                                                              },
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              border: Border.all(color: Colors.black26),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(CupertinoIcons.exclamationmark_circle_fill, size: 16),
                                                            Text("Geser ke kanan atau ke kiri untuk memilih", style: TextStyle(color: Colors.black, fontSize: 12,)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 24,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () => Navigator.pop(context),
                                                              child: Text('Kembali', style: TextStyle(color: Colors.green),),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors.lightGreen[100],
                                                                  minimumSize: Size(150, 40),
                                                                  padding: EdgeInsets.only(left: 32,top: 12, right: 32, bottom: 12)
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: ()  async{
                                                                if(_isSingle == false){
                                                                  _row = "Baris "+_currentValue.toString()+", Baris "+(_currentValue+1).toString();
                                                                }else{
                                                                  _row = "Baris "+_currentValue.toString();
                                                                }
                                                                await _addBlockItem(block.name!, _row, _model);
                                                                Navigator.pop(context);
                                                                Navigator.pop(mContext);
                                                              },
                                                              child: Text('Buat'),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: Colors.green,
                                                                  minimumSize: Size(150, 40),
                                                                  padding: EdgeInsets.only(left: 32,top: 12, right: 32, bottom: 12)
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),]);
                                          });
                                    });
                              },
                            ),
                            color: Colors.grey[200],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      }))
                ],
              );
            },
          );
        });
  }

  Future<void> _addBlockItem(String name, String row, String model) async {
    await SQLHelper.createBlockItem(
        name, row, model);
    _refreshBlocks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pemanen'),
        actions: [],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 32,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(48), // Image radius
              child: Image.asset(
                'assets/images/profile.png',
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Sulaiman Johan", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 24,)),
          SizedBox(
            height: 8,
          ),
          Text("293019293", style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child:Align(
            alignment: Alignment.bottomLeft,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Panen Tanggal", style: TextStyle(fontWeight: FontWeight.bold,), textAlign: TextAlign.start,),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.black,),
                        Text("10 Agustus 2021", style: TextStyle(fontSize: 16,)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hasil Panen", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("3 Ha 1.800 Kg 105 Jjg", style: TextStyle(fontSize: 16,)),
                  ],
                ),
              ],
            ),),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text("Blok Panen Kemarin", style: TextStyle(fontWeight: FontWeight.bold,
              ), textAlign: TextAlign.start,),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Container(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("A21",style: TextStyle(color: Colors.green)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.green),
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("A22",style: TextStyle(color: Colors.green)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.green),
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("A23",style: TextStyle(color: Colors.green)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.green),
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text("A24",style: TextStyle(color: Colors.green)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.green),
                          ),
                        )
                    ),
                  ),
                ],
              )
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _blocks.isEmpty
              ?
          Padding(padding: EdgeInsets.only(top: 100), child: Text('Mutu Ancak Masih Kosong ',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),)
              :
          Expanded(
              child: ListView.builder(
                itemCount: _blocks.length,
                itemBuilder: (context, index) =>
                    Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8 ),
                  child: ListTile(
                      title: Row(children: [
                        Text('Block : '+_blocks[index]['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 8,
                        ),
                        _blocks[index]['model'] == "Tunggal" ? Text(_blocks[index]['model'],style: TextStyle(color: Colors.blue, fontSize: 12), ) : Text(_blocks[index]['model'],style: TextStyle(color: Colors.green, fontSize: 12), )
                      ],),

                      subtitle: Text(_blocks[index]['row']),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addBlock(context),
        tooltip: 'Add Home',
        child: const Icon(Icons.add),
      ),
    );
  }
}


