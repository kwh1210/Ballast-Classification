# Ballast-Classification

Notes from YiFeng : 

Download matconvnet

Compile (refer to the guide on the website)

Setup (refer to the guide on the website)

Replace the function &lt;matconvnet_file&gt;/matlab/simplenn/vl_simplenn

Replace the function &lt;matconvnet_file&gt;/examples/cnn_train.m

Replace the function &lt;matconvnet_file&gt;/examples/mnist/cnn_mnist_experiments.m

And modify the &lt;matconvnet_file&gt;/examples/mnist/cnn_mnist_init.m according to the

architectures in my report

And add “data” file (contain “imdb” which you can get from /processedData after you

execute the code in laser-method- file) to the directory

&lt;matconvnet_file&gt;/examples/mnist/data

Note: when you run the cnn_mnist_experiments.m, make sure you are in

&lt;matconvnet_file&gt;/examples/mnist/
