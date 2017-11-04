MMADIR = /opt/bwhpc/fr/math/mathematica/11.1.1/SystemFiles/Links/MathLink/DeveloperKit/Linux-x86-64/CompilerAdditions
MPREP = $(MMADIR)/mprep
CXX = g++
DELETE = rm -f

CXXFLAGS = -I${HOME}/.usr/include -I$(MMADIR)
LDFLAGS = $(CXXFLAGS) -L$(HOME)/.usr/lib -L$(MMADIR) -lML64i4 -lrt -luuid -ldl -lFermat

OBJ = MathLink.o mmaFermat.o
OUT = mmaFermat

all:	$(OUT)

clean:
	$(DELETE) $(OUT)
	$(DELETE) $(OBJ)
	$(DELETE) MathLink.cpp

$(OUT):	$(OBJ) 
	$(CXX) $(OBJ) -o $(OUT) $(LDFLAGS) 

%.o:	%.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) 

%.cpp:	%.tm
	$(MPREP) $< -o $@

