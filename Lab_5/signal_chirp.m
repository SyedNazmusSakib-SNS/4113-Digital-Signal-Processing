"""
Signal Generation Module - Chirp Signal
"""
import numpy as np
from scipy import signal as sig

def generate_chirp_signal(f0, f1, duration, samples_per_second=1000):
    """
    Generate a frequency-swept signal (chirp)
    
    Parameters:
    -----------
    f0 : float
        Starting frequency in Hz
    f1 : float
        Ending frequency in Hz
    duration : float
        Signal duration in seconds
    samples_per_second : float
        Sampling rate (default: 1000 Hz)
    
    Returns:
    --------
    x : ndarray
        The chirp signal
    t : ndarray
        Time vector
    params : dict
        Dictionary containing signal parameters
    """
    # Calculate sampling parameters
    sampling_period = 1 / samples_per_second
    
    # Create time vector
    t = np.arange(0, duration, sampling_period)
    
    # Generate chirp signal
    x = sig.chirp(t, f0, duration, f1)
    
    # Store parameters
    params = {
        'start_frequency': f0,
        'end_frequency': f1,
        'duration': duration,
        'sampling_period': sampling_period,
        'sampling_frequency': samples_per_second,
        'num_samples': len(x),
        'frequency_sweep_rate': (f1 - f0) / duration
    }
    
    print(f"Chirp Signal Generated:")
    print(f"  Start Frequency: {f0:.2f} Hz")
    print(f"  End Frequency: {f1:.2f} Hz")
    print(f"  Duration: {duration:.2f} seconds")
    print(f"  Sweep Rate: {params['frequency_sweep_rate']:.2f} Hz/s")
    print(f"  Total samples: {len(x)}")
    
    return x, t, params