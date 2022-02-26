
NVCC = /usr/bin/nvcc
CC = g++

#No optmization flags
#--compiler-options sends option to host compiler; -Wall is all warnings
#NVCCFLAGS = -c --compiler-options -Wall

#Optimization flags: -O2 gets sent to host compiler; -Xptxas -O2 is for
#optimizing PTX
NVCCFLAGS = -c -O2 -Xptxas -O2 --compiler-options -Wall

#Flags for debugging
#NVCCFLAGS = -c -G --compiler-options -Wall --compiler-options -g


OBJS = wrappers.o convolute.o h_convolute.o d_convolute.o
.SUFFIXES: .cu .o .h 
.cu.o:
	$(NVCC) $(CC_FLAGS) $(NVCCFLAGS) $(GENCODE_FLAGS) $< -o $@

convolute: $(OBJS)
	$(CC) $(OBJS) -L/usr/local/cuda/lib64 -lcuda -lcudart -o convolute

convolute.o: convolute.cu h_convolute.h d_convolute.h config.h

h_convolute.o: h_convolute.cu h_convolute.h CHECK.h

d_convolute.o: d_convolute.cu d_convolute.h CHECK.h config.h

wrappers.o: wrappers.cu wrappers.h

clean:
	rm convolute *.o
