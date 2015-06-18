// vim: set noet:

#include "path.hpp"
#include <fstream>
#include <stdexcept>

std::string pe_data_file(std::string const &basename) {
	std::ifstream in;
	in.open(basename);
	if (in)
		return basename;
	in.open("data/" + basename);
	if (in)
		return "data/" + basename;
	in.open("../data/" + basename);
	if (in)
		return "../data/" + basename;
	throw std::runtime_error("Failed to open file \"" + basename + "\"");
}

