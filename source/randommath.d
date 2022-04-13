import basic;
int avoidlast(int max,int last){
	auto x=uniform(0,max-1);
	if(x>=last){
		x++;
	}
	return x;
}
unittest{
	int last=0;
	int[10] results;
	foreach(i;0..1000){
		int x=avoidlast(10,last);
		assert(x!=last);
		results[x]++;
		last=x;
	}
	results.writeln;
}

int bellcurve(int max){
	return 
		uniform(0,max/2+1)+
		uniform(0,max/2+max%2);
}
unittest{
	int[17] results;
	foreach(i;0..10000){
		results[bellcurve(17)]++;
	}
	results.writeln;
}
float avoidlast(float max, float range, float last){
	auto max_=max-range;
	auto x=uniform(0,max_/2)+uniform(0,max_/2);
	if(x>=last-range/2){
		x+=range;
	}
	return x;
}
unittest{
	"----".writeln;
	int[100] d;
	int[100] i;
	float last;
	foreach(j;0..10000000){
		auto x=avoidlast(100.0,20.0,last);
		last=x;
		int x_=cast(int)x.floor;
		i[x_]++;
		x-=x_;
		x*=100;
		x_=cast(int)x.floor;
		d[x_]++;
	}
	i.writeln;
	d.writeln;
}