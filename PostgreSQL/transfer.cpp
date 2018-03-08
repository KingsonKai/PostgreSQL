#include<iostream>
#include<fstream>
#include<string>
#include<vector>
using namespace std;
vector<string> getSubstrings(string s, string c) {
	string::size_type pos;
	vector<string> result;
	int size = s.size();
	for (int i = 0; i < size; i++) {	//get the values of one item
		pos = s.find(c, i);
		if(pos < size) {
			result.push_back(s.substr(i, pos-i));
			i = pos + c.size() -1;
		}
	}
	return result;
}
int main() {
	string s;
	int i, j;
	ifstream in;
	in.open("./../lineitem.tbl");		//get the source  data
	ofstream out;
	out.open("lineitem.json");		//set the target document
	string title[16] = { "\"ORDERKEY\"","\"PARTKEY\"","\"SUPPKEY\"",
			"\"LINENUMBER\"","\"QUANTITY\"","\"EXTENDEDPRICE\"",
			"\"DISCOUNT\"","\"TAX\"","\"RETURNFLAG\"",
			"\"LINESTATUS\"","\"SHIPDATE\"","\"COMMITDATE\"",
			"\"RECEIPTDATE\"","\"SHIPINSTRUCT\"","\"SHIPMODE\"",
			"\"COMMENT\""};
	if (in.is_open()) {
		for (i = 1; getline(in, s); i++) {
			vector<string> result = getSubstrings(s, "|");
			s = "\t{";
			if (result.size() == 16) {
				out << i;
				for (j = 0; j < 15; j++) {		//transfer to json form
					s = s + title[j] + ":\"" + result[j] + "\",";
				}
				s = s + title[j] + ":\"" + result[j] + "\"}\n";
				out << s;
			}
		}
		out.close();
	}
}