import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChartScreen(),
    );
  }
}

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    //data for pie chart + legend
    final pieSections = showingPieSections();
    final legendItems = [
      LegendItem('Blue', Colors.blue),
      LegendItem('Red', Colors.red),
      LegendItem('Green', Colors.green),
      LegendItem('Orange', Colors.orange),
    ];

    //data for bar chart legend
    final barLegendItems = [
      LegendItem('Attribute 1', Colors.blue[200]!),
      LegendItem('Attribute 2', Colors.red[200]!),
    ];

  

    return Scaffold(
      appBar: AppBar(
        title: Text('Charts Example'),
      ),
      body: SingleChildScrollView( // Allows scrolling
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              //centered title for  pie chart
              Text(
                'Title 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),


              SizedBox(height: 30), //space between title and pie chart



              //row for pie chart + legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //pie chart
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.4,
                      maxHeight: screenSize.height * 0.4, //fixed height for pie chart
                    ),


                    child: PieChart(
                      PieChartData(
                        sections: pieSections,
                        borderData: FlBorderData(show: false),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),


                    ),
                  ),


                  SizedBox(width: 20),

                  //legend next to the pie chart
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: legendItems.map((item) {

                      return Row(
                        children: [

                          Container(
                            width: 20,
                            height: 20,
                            color: item.color,
                          ),


                          SizedBox(width: 8),


                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),



                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),




              SizedBox(height: 70), //space between pie chart and bar chart




              //label for the bar chart
              Text(
                'Title 2',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),




              SizedBox(height: 20), // Space between title and legend




              //bar chart legend section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: barLegendItems.map((item) {

                  return Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: item.color,
                      ),


                      SizedBox(width: 8),


                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                      SizedBox(width: 20), //spacing between legend items
                    ],
                  );
                }).toList(),
              ),


              SizedBox(height: 60), // Space between legend and bar chart



              //bar chart section
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width * 0.8,
                  maxHeight: screenSize.height * 0.3, //fixed height for bar chart
                ),


                child: SimpleBarChart(
                  xAxisList: ['Jan', 'Feb', 'Mar', 'Apr'],
                  yAxisList: [
                    [5, 3],
                    [4, 2],
                    [7, 6],
                    [8, 5],
                  ],

                  xAxisName: 'Months',
                  yAxisName: 'Values',

                  interval: 1,

                ),
              ),
             

              SizedBox(height: 30), //extra space below the bar chart

             


            ],
          ),
        ),
      ),
    );
  }




  //pie chart sections
  List<PieChartSectionData> showingPieSections() {
    return List.generate(4, (i) {


      switch (i) {
        case 0:
          return PieChartSectionData(
                    color: Colors.blue,
                    value: 30,
                    title: '30%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
          );
        case 1:
          return PieChartSectionData(
                    color: Colors.red,
                    value: 40,
                    title: '40%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
            ),
          );
        case 2:
          return PieChartSectionData(
                    color: Colors.green,
                    value: 20,
                    title: '20%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
            ),
          );
        case 3:
          return PieChartSectionData(
                    color: Colors.orange,
                    value: 10,
                    title: '10%',
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}







//class for legend items
class LegendItem {
  final String label;
  final Color color;

  LegendItem(this.label, this.color);
}




//bar chart class
class SimpleBarChart extends StatefulWidget {
  final List<String> xAxisList;
  final String xAxisName;
  final List<List<double>> yAxisList; //multiple values for each x-axis label
  final String yAxisName;
  final double interval;

  const SimpleBarChart({
    super.key,
    required this.xAxisList,
    required this.yAxisList,
    required this.xAxisName,
    required this.yAxisName,
    required this.interval,
  });

  @override
  State<SimpleBarChart> createState() => _SimpleBarChartState();
}





class _SimpleBarChartState extends State<SimpleBarChart> {
  late List<String> xAxisList;
  late List<List<double>> yAxisList; //multiple values per x-axis
  late String xAxisName;
  late String yAxisName;
  late double interval;

  @override
  void initState() {
    super.initState();
    xAxisList = widget.xAxisList;
    yAxisList = widget.yAxisList;
    xAxisName = widget.xAxisName;
    yAxisName = widget.yAxisName;
    interval = widget.interval;
  }



  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,

          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),


          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),


          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              xAxisName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => bottomTitles(value, meta, xAxisList),
              reservedSize: 42,
            ),
          ),



          leftTitles: AxisTitles(
            axisNameWidget: Padding(
              padding: const EdgeInsets.only(left: 55.0), 
              child: Text(
                yAxisName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              interval: interval,
              getTitlesWidget: barChartLeftTitles,
            ),
          ),


        ),



        borderData: FlBorderData(
          border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          ),
        ),



        gridData: FlGridData(show: false),
        barGroups: List.generate(
          xAxisList.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: List.generate(
              yAxisList[index].length,
              (attrIndex) => BarChartRodData(
                toY: yAxisList[index][attrIndex],
                width: 25, //adjust bar width to fit multiple bars
                color: attrIndex.isEven ? Colors.blue[200] : Colors.red[200],
                borderRadius: BorderRadius.zero, //make the ends square
              ),
            ),
          ),
        ),
        maxY: yAxisList.expand((i) => i).reduce((a, b) => a > b ? a : b) + 1,
      ),
    );
  }





  Widget bottomTitles(double value, TitleMeta meta, List<String> xAxisList) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }






  Widget barChartLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '1';
        break;
      case 2:
        text = '2';
        break;
      case 3:
        text = '3';
        break;
      case 4:
        text = '4';
        break;
      case 5:
        text = '5';
        break;
      case 6:
        text = '6';
        break;
      case 7:
        text = '7';
        break;
      case 8:
        text = '8';
        break;
      case 9:
        text = '9';
        break;
      default:
        return const SizedBox.shrink();
    }
    return SideTitleWidget(child: Text(text, style: style), axisSide: meta.axisSide);
  }
}
