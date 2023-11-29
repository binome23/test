import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



const d_green = const Color(0xFF54D3C2);
DateTime kNow=DateTime.now(); // date du jour
DateTime kFirstDay=DateTime(kNow.year,kNow.month-3,kNow.day); // date du jour
DateTime kLastDay=DateTime(kNow.year,kNow.month+3,kNow.day); // date du jour


class CalendarPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          PeriodSection(),
          CalendarRange(),
          ValidateBookingSection(),
        ],
      ),
    );
  }

}


class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: IconButton(
        icon:
        Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
    );
  }

}


class PeriodSection extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Depart',
                  textAlign: TextAlign.left,
                  style:TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[700]
                  ),
                ),
                SizedBox(height: 4,),

                Text(
                  'Month 12 Dec',
                 // textAlign: TextAlign.left,
                  style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      //color: Colors.grey[700]
                  ),
                ),

              ],
            ),
            Container(height: 60, width: 2,color: Colors.grey[350],),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'return',

                  style:TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey[700]
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  'Tues 22 Dec',

                  style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[700]
                  ),
                ),

              ],
            ),
          ],
        ),
        Divider(color: Colors.grey, height: 2,)
      ],
    );
  }
}

class CalendarRange extends StatefulWidget {
  @override
  _CalendarRangeState createState() => _CalendarRangeState();


}
class _CalendarRangeState extends State<CalendarRange> {
  CalendarFormat _CalenderFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;


  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.grey[10],
      child: Expanded(
        child: TableCalendar(
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day)=>isSameDay(_selectedDay,day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _CalenderFormat,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(fontSize: 18),

          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            rangeHighlightColor: d_green,
            rangeStartDecoration: BoxDecoration(
              color: d_green,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(
                  color: Colors.white,
                  width: 3,
                  style: BorderStyle.solid,
                ),

              ),
            ),

          ) ,

          firstDay: kFirstDay,
          rangeSelectionMode: _rangeSelectionMode,


          onDaySelected:(selectedDay,focusedDay){
            if(!isSameDay(_selectedDay, selectedDay)){
              setState(() {
                _selectedDay=selectedDay;
                _focusedDay=focusedDay;
                _rangeStart=null;

                _rangeEnd=null;
                _rangeSelectionMode=RangeSelectionMode.toggledOff;


              });

            }

          },
          onRangeSelected:(start,end,focusedDay){
            setState(() {
              _selectedDay=null;
              _focusedDay=focusedDay;
              _rangeStart=start;
              _rangeEnd=end;
              _rangeSelectionMode=RangeSelectionMode.toggledOn;

            });
          },
          onFormatChanged:(format) {
            if(_CalenderFormat!=format){
              setState(() {
                _CalenderFormat=format;
              });
            }
          } ,


        ),
      ),
    );
  }
}



class ValidateBookingSection extends StatelessWidget{
  final selectedRadio=1;
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        RadioListTile(
            value: selectedRadio,
            groupValue: selectedRadio,
            activeColor: d_green,
            onChanged: null,
            selected: true,
            title: Text(
              'flexibale date',
              style: new TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child:
          ElevatedButton(

            child:
            Text(
            'appy',
            style: TextStyle(fontSize: 16.0),),
            style: ElevatedButton.styleFrom(
              primary: d_green,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),

            ),
            onPressed: () {
              print('Applyblocking');
              Navigator.pop(context);
            },
          ),



        ),
      ],

    );
  }

}
