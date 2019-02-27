
// abstract Class
abstract class TestAbstractClass{

  // abstract method
  void abstractMethod();

}


// A normal class that implements an abstract class
class TestClass implements TestAbstractClass{

  String name;

  // constructor
  TestClass(this.name);

  // getter and setter
  get getName => this.name;
  set setName(String Value) => this.name = Value;


  // regular class method
  void classMethod(){
    print("Class method called");
  }


  // abstract method that has to be implemented
  @override
  abstractMethod(){
    print("This is an abstract method that had to be implemented");
  }

}



// a normal class that inherits from another class and implements
// an abstract class
class InheritedClass extends TestClass implements TestAbstractClass{


  // I have to do this as the super class has a non
  // empty constructor
  // Note: the name var can only be trasfered to the super class
  //       as the var is not declared in this class
  InheritedClass(String name): super(name);


  // abstract method that has to be implemented
  @override
  abstractMethod(){
    print("This is an abstract method that is implemented insided a inherited class");
  }

}


// This class is the super class of NamedParams and is used to demonstrate
// named params thats declared in NamedParams class
class NamedParamsSuperClass{

  String First;
  String Second;

  // constructor using named params notation i.e it uses {}
  // Note: All the vars that are declared inside the braces
  //       are optional
  NamedParamsSuperClass({this.First, this.Second});

  void superDisplay(){
    print(this.First);
    // this.second will be null as its not set in the sub class
    print(this.Second);
  }

}


// class to demonstrate named params
class NamedParams extends NamedParamsSuperClass{

  String classFirst;
  String classSecond;

  // named params are like **kwargs, since the classFirst and classSecond
  // vars are declared in the class you can just pass this.classFirst and
  // this.classSecond in the constructor. When you initialize the class
  // you then have to explicitly map the values like this (classSecond: "IamClassSecond")
  // Also note, since you don't have String first and String second declared
  // in the class level you can access them inside this class, however you
  // can pass the values of first and second to the super function using the named
  // params of the super function
  NamedParams(
      {String first, String second, this.classSecond, this.classFirst}
      ): super(First: first, Second: second);

  void display(){
    print(this.classSecond);
    // this.classFirst will be null as its not set in the class initialization
    print(this.classFirst);
  }

}


// regular method
void test(){

  // Map with multi type keys
  var a = {

    'a' : 1,
    'b': 2,
    'c': 3,
    1 : 'g'

  };

  // list with multi type values
  var b = ['a', 'b', 'c', 1];

  // I am mapping the list vars to the maps keys
  for (var i=0; i < b.length; i++){

    print(a[b[i]]);

  }

}


// main function
void main() {

  // calling the regular method
  test();


  // initializing a normal class that implements an abstract method
  TestClass t = TestClass("mohan");
  // Note how I use the getter and setter
  print(t.getName);
  t.setName = "Kumar";
  print(t.getName);
  // calling class method
  t.classMethod();
  // calling the implemented abtract method
  t.abstractMethod();


  // initializing inherited methods
  InheritedClass i = InheritedClass("Madhavan");
  // calling the super class getter
  print(i.getName);
  // calling the implemented abtract method inside the inherited class
  i.abstractMethod();


  // initializing the named params class
  // note how I am passing values to the NamedParams class
  // I am just setting classSecond and the first vars here
  // the first var is in turn set to the First var in NamedParamsSuperClass
  NamedParams n = NamedParams(classSecond: "IamClassSecond", first: "IamFirst");
  // calling class method
  n.display();
  // calling super class method
  n.superDisplay();

}

