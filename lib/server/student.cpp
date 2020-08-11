#include<iostream>
#include<string>
using namespace std;
class CStudent{
private:
string stu_name;
string stu_no;
int stu_score;
public:
CStudent(string name, string no, int score){
stu_name = name;
stu_no = no;
stu_score = score;
}
void set_name(string name){stu_name = name;}
void set_no(string no){stu_no = no;}
void set_score(int score){stu_score = score;}
string get_name(){return stu_name;}
string get_no(){return stu_no;}
int get_score(){return stu_score;}
friend void statis_students(CStudent [], int num, int max_score, int min_score);
};
void statis_students(CStudent stus[], int num, int max_score, int min_score){
max_score = stus[0].stu_score;
min_score = stus[0].stu_score;
int avg_score = 0,i;
for(i = 0; i<num; i++){
avg_score+=stus[i].stu_score;
if(stus[i].stu_score > max_score){
max_score = stus[i].stu_score;
}
if(stus[i].stu_score<min_score){
min_score = stus[i].stu_score;
}
}
avg_score/=num;
cout<<"Students' name above the average score:"<<endl;
for(i = 0; i<num; i++){
if(avg_score < stus[i].stu_score){
cout<<stus[i].stu_name<<endl;
}
}
}
int main(){
CStudent stus[3] = {CStudent("10", "li", 100),CStudent("11", "wang", 89), CStudent("12", "zhao",70)};
int max_score, min_score;
statis_students(stus,3, max_score, min_score);
cout<<"the max score"<<endl;
cout<<max_score<<endl;
cout<<"the min score"<<endl;
cout<<min_score<<endl;
return 0;
}
