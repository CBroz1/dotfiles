import warnings

warnings.filterwarnings("ignore", module="numba")
warnings.filterwarnings("ignore", module="hdmf")
warnings.filterwarnings("ignore", category=UserWarning, module="pynwb")
warnings.filterwarnings("ignore", category=DeprecationWarning, module="spikeinterface")
warnings.filterwarnings("ignore", category=DeprecationWarning, module="numpy")
warnings.filterwarnings("ignore", category=DeprecationWarning, module="numpy")
