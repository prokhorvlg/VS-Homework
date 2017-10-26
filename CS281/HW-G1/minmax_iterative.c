// Array of numbers - the min and max will be extracted from it using the program.

int A[10] =
 {
  11, 2, 33, 4, 15, 6, 7, 8, 9, 10
 };

// main function
// This function is run when the program is run.

// It is meant to set up and run the function MinMaxIt(),
// and is then supposed to display the results of running MinMaxIt().

// 

main ()
 {

  // set up variables 
  int min, max;

  // run MinMaxIt function.
  // Accepts the array of numbers, size of the array, and pointers to the locations of the minimum and maximum variables.
  // This function will modify the min and max variables.
  MinMaxIt (A, 10, &min, &max) ;

  // These lines print the results of the MinMaxIt function
  // by calling their own print functions.
  print_str("MinMaxIt = ");
  print_int(min); print_str("  ");
  print_int(max); print_str("\n");

  // The programs ends.
  return(0);
 }

// MinMaxIt function
// This function is run when called within main.

// This is a math function that is designed to locate the minimum and maximum values in an array. 

// It does this by running a for loop through the array, making comparisons on each iteration.
// Within each comparison, if the current item is larger than the current max var, set it to be the new max. Vice versa with min var.

MinMaxIt (A, n, _min, _max)

// Registers the variables used in this function. The array, number of elements in array int, min int, and max int.
register int * A;
register unsigned int n;
register int * _min;
register int * _max;
 {
  // Registers a temporarily used min and max var
  register int min asm ("s5") ;
  register int max asm ("s6") ;
  register int *p  asm ("s7") ;

  // Sets the min and max vars to be equal to the first element in the array.
  min = A[0];
  max = A[0];

  // Runs a for loop through the array, using the var number of elements as the ceiling.
  for (p = &A[1]; p < &A[n]; p ++ ) 
   {
    // Makes a comparison on each item. If the item is larger than the current max, then set it to be the new max. Vice versa for min var.
    if ( * p < min) min = * p;
    if ( * p > max) max = * p;
   }

   // Sets the original min and max variables to the temporary ones used in the function, then exit/
  * _max = max;
  * _min = min;
  return(0);
 }

__main ()
 {
  return(0);
 }

dummy (v)
int v;
 {
  return(0);
 }

print_int (value)
int value;
 {
  int code;
  code = 1;
  asm (
       "add $a0,%1,$zero\n\t"
       "add $v0,%0,$zero\n\t"
       "syscall"
       :
       : "r" (code), "r" (value));
  return(value);
 }

print_hex (value)
int value;
 {
  char s[10];
  itox(value,s);
  print_str(s);
  return(value);
 }

print_str (str)
char *str;
 {
  int code;
  code = 4;
  asm (
       "add $a0,%1,$zero\n\t"
       "add $v0,%0,$zero\n\t"
       "syscall"
       :
       : "r" (code), "r" (str));
  return(0);
 }

/*
  itox converts v to eight hex digits and stores them in str[]
  such that str[0] is the leftmost digit (msd) and str[7] is the rightmost (lsd)
*/

itox (v,str)
int v;
char *str;
 {
  int i, j, t;
  j = 7;
  for (i = 0; i < 8; i++)
   {
    t = v & 0x0f;
    if (t < 10) str[j] = t + '0';
     else str[j] = t - 10 + 'A';
    v = v >> 4;
    j--;
   }
  str[8] = 0;
  return(v);
 }

print_stack (var0)
int var0;
 {
  int *p, v, i, k;
  k = 42;
  p = &var0;
  v = (int) p;
  print_hex(v);
  print_str("\n");
  p = p - 20;
  for (i = 0; i < 82; i++)
   {
    v = (int) p;    print_hex(v);    print_str("  ");
    v =      *p;    print_hex(v);    print_str("\n");
    p++;
   }
  return(k);
 }
