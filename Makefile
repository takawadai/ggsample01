TARGET	= ggsample01
SOURCES	= $(wildcard *.cpp) $(wildcard lib/imgui*.cpp) lib/nfd_gtk.cpp
HEADERS	= $(wildcard *.h) $(wildcard lib/*.h)
OBJECTS	= $(patsubst %.cpp,%.o,$(SOURCES))
CXXFLAGS	= --std=c++17 -g -Wall -DDEBUG -DX11 `pkg-config glfw3 --libs` `pkg-config gtk+-3.0 --cflags` -Iinclude
LDLIBS	= -ldl `pkg-config glfw3 --libs` `pkg-config gtk+-3.0 --libs`

.PHONY: clean

$(TARGET): $(OBJECTS)
	$(LINK.cc) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(TARGET).dep: $(SOURCES) $(HEADERS)
	$(CXX) $(CXXFLAGS) -MM $(SOURCES) > $@

clean:
	-$(RM) $(TARGET) *.o lib/*.o *~ .*~ *.bak *.dep imgui.ini a.out core

-include $(TARGET).dep
