# This is where we will store our project code as we develop it.
# The Stegocode as of (9/06/2024)

-We are able to embed a bit sequence and decode it from a black and white image and then extract it

-We are able to embed a smaller black and white photo in a larger one and then extract it

-We are able to embed a smaller colored image inside a larger one amd then extract it

-We are able to embed a string or sentence inside a colored image then extract it

# TRANSMISSION CODE as of 10/24/2024

-working transmission and reception on one radio(full duplex).
  -break down an image into bits
  -break down image into 8192 or 1kb sized arrays
  -creates a BPSK signal with 2 symbols per bit of that image array.
  -Each transmission has a 11 length barker sequence as the preamble
  -transmits these signals over in a loop
    -each time a signal is received, receiver looks for premable with cross correlation and then takes out the 2*1kb worth of sin numbers from the samples
    -from here, the extracted bits are then processed removing redundancy and converting back to 0 and 1
    -these 0's and 1's are placed in back into an array, that once all loops are finsihed, should have the reconstructed image information
  -reconstructs the image back to png and saves it to computer from the image array that was appended to after each loop
  
-has a short 4 length DSSS spreading sequence version that also works, just has a spreading step before transmission that is applied only to the data and not the preabmle, and also a despreading step that is done after the preamble is found and the spreaded bits are extracted.

# Screenshots of output to check if things are working like for us
(Successful Cross Corelated regular 10 bit long transmissions)
![image](https://github.com/user-attachments/assets/37b4e735-849c-419b-af27-73e36830c64b)
![image](https://github.com/user-attachments/assets/0dcb997e-834f-4fea-809b-228ba96759f7)
(successful DSSS of small 10 bit transmission)
![image](https://github.com/user-attachments/assets/cf95e2e9-c352-4a33-9150-5cab7b476b7d)
(successful Cross correlated sending of the image with and without DSSS respectivly)
![image](https://github.com/user-attachments/assets/5709265d-7e74-45d1-8426-5678292c5842)
![image](https://github.com/user-attachments/assets/02d2ced5-9375-4944-a292-4e0933430143)
*Note, as of now, sometimes there seems to be what I think is a small synchronization issue that causes rx_samples to be small and taper off to zero
![image](https://github.com/user-attachments/assets/88bc8243-e674-418e-8085-29e88cf49e37)




