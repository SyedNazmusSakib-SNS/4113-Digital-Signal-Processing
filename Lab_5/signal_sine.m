"""
Signal Generation Module - Sine Wave
"""
import numpy as np

def generate_sine_wave(freq, amplitude, phase, num_periods, samples_per_period=100):
    """
    Generate a sinusoidal signal
    
    Parameters:
    -----------
    freq : float
        Frequency in Hz
    amplitude : float
        Amplitude of the sine wave
    phase : float
        Phase shift in degrees (default: 0)
    num_periods : int
        How many periods to generate
    samples_per_period : int
        Number of samples per period (default: 100)
    
    Returns:
    --------
    x : ndarray
        The sine wave signal
    t : ndarray
        Time vector
    params : dict
        Dictionary containing signal parameters
    """
    # Calculate time parameters
    time_period = 1 / freq
    sampling_period = time_period / samples_per_period
    
    # Create time vector
    t = np.arange(0, num_periods * time_period, sampling_period)
    
    # Generate sine wave: A*sin(2*pi*f*t + phi)
    phase_rad = phase * np.pi / 180  # Convert to radians
    x = amplitude * np.sin(2 * np.pi * freq * t + phase_rad)
    
    # Store parameters
    params = {
        'frequency': freq,
        'amplitude': amplitude,
        'phase_deg': phase,
        'phase_rad': phase_rad,
        'time_period': time_period,
        'sampling_period': sampling_period,
        'sampling_frequency': 1/sampling_period,
        'num_samples': len(x)
    }
    
    print(f"Sine Wave Generated:")
    print(f"  Frequency: {freq:.2e} Hz")
    print(f"  Amplitude: {amplitude:.2f}")
    print(f"  Phase: {phase:.2f} degrees")
    print(f"  Total samples: {len(x)}")
    
    return x, t, params