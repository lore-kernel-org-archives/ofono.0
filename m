Content-Type: multipart/mixed; boundary="===============9049340185651653464=="
MIME-Version: 1.0
From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: Quectel TCP/IP connection
Date: Wed, 08 May 2019 17:58:27 -0700
Message-ID: <CACUGKYOWNggcDmT12xLQ7Gz-qMrMzvSnKum0XJB5cHOOvFdeGg@mail.gmail.com>
In-Reply-To: <9b6eae26-9952-fcbd-4b45-dbd85d4a3654@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9049340185651653464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,



On Wed, May 8, 2019 at 5:21 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi John,
>
> On 05/08/2019 06:13 PM, John Tobias wrote:
> > Hi all,
> >
> > I was trying to integrate the quectel
> > <
> https://www.quectel.com/UploadImage/Downlad/Quectel_BG96_TCP(IP)_AT_Comma=
nds_Manual_V1.0.pdf> tcp/ip
>
> > connection in the ofono driver. I used AT+QIOPEN for opening the
> > socket, AT+QIRD for receiving data from the server and AT+QISENDEX for
> > sending data to the server.
> >
>
> Out of curiosity, why?  Since you're running oFono, which runs on Linux,
> you should have a fully-featured and much easier to use IP stack
> available to you?
>


The purpose is to put the device in sleep mode. While the device is in
sleep mode, the modem is running
in low power mode and it maintains the TCP/IP connection to the server. If
the server send a data, the modem
will able to wake up the device.


>
> > The 3 functions are working correctly if I executed it directly in the
> > serial port. I had issue with ofono when it send the AT+QISENDEX. Below
> > is the command:
> >
> > char const *command2 =3D "AT+QISENDEX=3D2,\"48656c6c6f\"";
> > g_at_chat_send(data->aux, command2, none_prefix, NULL, NULL,NULL);
> >
> >
> > The first execution of the QISENDEX works. My server received the data
> > but when I try it again, the ofono stuck somewhere where the it couldn't
> > run any AT commands anymore. Then, I killed the ofono and opened the
> > serial, I ran this command AT+QISENDEX=3D2,"48656c6c6f" and it works fi=
ne.
>
> You may want to enable AT command debugging.  See HACKING for details.
> One possibility is that the firmware gets AT command response formatting
> wrong.  E.g. something in the response confuses GAtSyntax.
>
>
Thanks, I will check it.


> Regards,
> -Denis
>


Regards,

John

--===============9049340185651653464==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGnCoERlbmlzLDxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgTWF5IDgsIDIwMTkgYXQgNToyMSBQTSBE
ZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtl
bnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13
aWR0aDoxcHg7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIw
NCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBKb2huLDxicj4KPGJyPgpPbiAwNS8wOC8y
MDE5IDA2OjEzIFBNLCBKb2huIFRvYmlhcyB3cm90ZTo8YnI+CiZndDsgSGkgYWxsLDxicj4KJmd0
OyA8YnI+CiZndDsgSSB3YXMgdHJ5aW5nIHRvIGludGVncmF0ZSB0aGUgcXVlY3RlbCA8YnI+CiZn
dDsgJmx0OzxhIGhyZWY9Imh0dHBzOi8vd3d3LnF1ZWN0ZWwuY29tL1VwbG9hZEltYWdlL0Rvd25s
YWQvUXVlY3RlbF9CRzk2X1RDUChJUClfQVRfQ29tbWFuZHNfTWFudWFsX1YxLjAucGRmIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5xdWVjdGVsLmNvbS9VcGxv
YWRJbWFnZS9Eb3dubGFkL1F1ZWN0ZWxfQkc5Nl9UQ1AoSVApX0FUX0NvbW1hbmRzX01hbnVhbF9W
MS4wLnBkZjwvYT4mZ3Q7wqB0Y3AvaXAgPGJyPgomZ3Q7IGNvbm5lY3Rpb24gaW4gdGhlIG9mb25v
IGRyaXZlci4gSSB1c2VkIEFUK1FJT1BFTiBmb3Igb3BlbmluZyB0aGUgPGJyPgomZ3Q7IHNvY2tl
dCzCoEFUK1FJUkQgZm9yIHJlY2VpdmluZyBkYXRhIGZyb20gdGhlIHNlcnZlciBhbmTCoEFUK1FJ
U0VOREVYIGZvciA8YnI+CiZndDsgc2VuZGluZyBkYXRhIHRvIHRoZSBzZXJ2ZXIuPGJyPgomZ3Q7
IDxicj4KPGJyPgpPdXQgb2YgY3VyaW9zaXR5LCB3aHk/wqAgU2luY2UgeW91JiMzOTtyZSBydW5u
aW5nIG9Gb25vLCB3aGljaCBydW5zIG9uIExpbnV4LCA8YnI+CnlvdSBzaG91bGQgaGF2ZSBhIGZ1
bGx5LWZlYXR1cmVkIGFuZCBtdWNoIGVhc2llciB0byB1c2UgSVAgc3RhY2sgPGJyPgphdmFpbGFi
bGUgdG8geW91Pzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5UaGUgcHVycG9zZSBpcyB0byBwdXQgdGhlIGRldmljZSBpbiBzbGVlcCBtb2RlLiBXaGls
ZSB0aGUgZGV2aWNlIGlzIGluIHNsZWVwIG1vZGUsIHRoZSBtb2RlbSBpcyBydW5uaW5nPC9kaXY+
PGRpdj5pbiBsb3cgcG93ZXIgbW9kZSBhbmQgaXQgbWFpbnRhaW5zIHRoZSBUQ1AvSVAgY29ubmVj
dGlvbiB0byB0aGUgc2VydmVyLiBJZiB0aGUgc2VydmVyIHNlbmQgYSBkYXRhLCB0aGUgbW9kZW08
L2Rpdj48ZGl2PndpbGwgYWJsZSB0byB3YWtlIHVwIHRoZSBkZXZpY2UuPC9kaXY+PGRpdj7CoDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNv
bGlkO2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
Cjxicj4KJmd0OyBUaGUgMyBmdW5jdGlvbnMgYXJlIHdvcmtpbmcgY29ycmVjdGx5IGlmIEkgZXhl
Y3V0ZWQgaXQgZGlyZWN0bHkgaW4gdGhlIDxicj4KJmd0OyBzZXJpYWwgcG9ydC4gSSBoYWQgaXNz
dWUgd2l0aCBvZm9ubyB3aGVuIGl0IHNlbmQgdGhlIEFUK1FJU0VOREVYLiBCZWxvdyA8YnI+CiZn
dDsgaXMgdGhlIGNvbW1hbmQ6PGJyPgomZ3Q7IDxicj4KJmd0OyBjaGFyIGNvbnN0ICpjb21tYW5k
MiA9ICZxdW90O0FUK1FJU0VOREVYPTIsXCZxdW90OzQ4NjU2YzZjNmZcJnF1b3Q7JnF1b3Q7Ozxi
cj4KJmd0OyBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDthdXgsIGNvbW1hbmQyLCBub25lX3ByZWZp
eCwgTlVMTCwgTlVMTCxOVUxMKTs8YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGUgZmly
c3QgZXhlY3V0aW9uIG9mIHRoZSBRSVNFTkRFWCB3b3Jrcy4gTXkgc2VydmVyIHJlY2VpdmVkIHRo
ZSBkYXRhIDxicj4KJmd0OyBidXQgd2hlbiBJIHRyeSBpdCBhZ2FpbiwgdGhlIG9mb25vIHN0dWNr
IHNvbWV3aGVyZSB3aGVyZSB0aGUgaXQgY291bGRuJiMzOTt0IDxicj4KJmd0OyBydW4gYW55IEFU
IGNvbW1hbmRzIGFueW1vcmUuIFRoZW4sIEkga2lsbGVkIHRoZSBvZm9ubyBhbmQgb3BlbmVkIHRo
ZSA8YnI+CiZndDsgc2VyaWFsLCBJIHJhbiB0aGlzIGNvbW1hbmTCoEFUK1FJU0VOREVYPTIsJnF1
b3Q7NDg2NTZjNmM2ZiZxdW90OyBhbmQgaXQgd29ya3MgZmluZS48YnI+Cjxicj4KWW91IG1heSB3
YW50IHRvIGVuYWJsZSBBVCBjb21tYW5kIGRlYnVnZ2luZy7CoCBTZWUgSEFDS0lORyBmb3IgZGV0
YWlscy4gPGJyPgpPbmUgcG9zc2liaWxpdHkgaXMgdGhhdCB0aGUgZmlybXdhcmUgZ2V0cyBBVCBj
b21tYW5kIHJlc3BvbnNlIGZvcm1hdHRpbmcgPGJyPgp3cm9uZy7CoCBFLmcuIHNvbWV0aGluZyBp
biB0aGUgcmVzcG9uc2UgY29uZnVzZXMgR0F0U3ludGF4Ljxicj4KPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcywgSSB3aWxsIGNoZWNrIGl0LjwvZGl2PjxkaXY+wqA8
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlk
O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+ClJl
Z2FyZHMsPGJyPgotRGVuaXM8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkpvaG7CoDwvZGl2
PjwvZGl2PjwvZGl2Pgo=

--===============9049340185651653464==--

