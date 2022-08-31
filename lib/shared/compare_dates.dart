bool compareDate(DateTime date1,DateTime date2)
{
  if( //1999 - 2000
  date1.year<=date2.year
  && date1.month<=date2.month
  && date1.day<=date2.day
  && date1.hour<=date2.hour
  && date1.minute<date2.minute
  )  {
    return false;
  }
  return true;
}