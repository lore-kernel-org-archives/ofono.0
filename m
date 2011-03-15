Content-Type: multipart/mixed; boundary="===============3075235617956515151=="
MIME-Version: 1.0
From: Andreas Hohn <Andreas.Hohn@alpine.de>
Subject: RE: [HELP Required]Routing Of SCO data to BT Host Speaker
Date: Tue, 15 Mar 2011 15:34:45 +0100
Message-ID: <OF84AEB74A.9EAB7D3A-ONC1257854.004D4F88-C1257854.005015F3@alpine.de>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836214DEF015CB@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3075235617956515151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

I'm not sure if you succeeded in the mean time. =


we had a similar issue when we used the Fedora pre-installed pulseaudio =

version.

When I downloaded and compiled the latest sources it wouked in our case. =


Regards,
Andreas
 =



ofono-bounces(a)ofono.org wrote on 11.03.2011 15:43:59:

> Hi Daniel,
> =

> Thanks for the quick assistance.
> =

> I tried the same approach as suggested by you.
> =

> Steps:
> ------
> 1.$pacmd
> 2.$list-sources
> ( got 2 sources )
> =

>   name: <alsa_output.pci-0000_00_05.0.analog-stereo.monitor>
> =

>   (and)
> =

>   name: <alsa_input.pci-0000_00_05.0.analog-stereo>
> 3.$list-sinks
> ( got 1 sink )
> =

> name: <alsa_output.pci-0000_00_05.0.analog-stereo>
> =

> 4.created a shell script "ofono.sh" with contents as below:
> pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_05.
> 0.analog-stereo" sink=3D"bluez_sink.A8_7E_33_AF_23_A4"
> pactl load-module module-loopback source=3D"bluez_source.
> A8_7E_33_AF_23_A4" sink=3D"alsa_output.pci-0000_00_05.0.analog-stereo"
> (A8_7E_33_AF_23_A4 is the BT address of handset paired to the host)
> =

> 5. Now I connect the host to the handset through HFP.
> 6.After SLC is established , I dial a number and establish a voice call.
> 7.As soon as the state is "Playing" ( SCO connected) , I run the =

> "ofono.sh" ( as mentioned in step 4).
> =

> Result:
> -------
> I am getting the following errors:
> =

> Failure: Module initalization failed
> Failure: Module initalization failed
> =

> =

> Requesting Clarification
> ------------------------
> 1.I was wondering if any modification is required in pulseaudio =

> configuration files to enable dynamic loading of module-loopback.( =

> e.g "module-loading =3D yes" in /etc/pulse/daemon.conf ).Currently all
> settings are maintained as default.
> =

> 2.Also, do I need to modify "SCORouting=3DPCM" in "audio.conf" file. =

> (default is HCI)
> =

> It will be of great help to receive any further inputs regarding the
> above issue.
> =

> Best Regards,
> Milan
> =

> -----Original Message-----
> From: Daniel Wagner [mailto:wagi(a)monom.org]
> Sent: Friday, March 11, 2011 12:52 PM
> To: Satpathy, Milan
> Cc: ofono(a)ofono.org
> Subject: Re: [HELP Required]Routing Of SCO data to BT Host Speaker
> =

> Hi Milan,
> =

> On Fri, Mar 11, 2011 at 10:56:34AM +0530, milan.satpathy(a)accenture.com =

wrote:
> > Hi,
> >
> > Recently I have been trying to use Ofono to write a Handsfree =

> based application( Using C on Ubuntu 10.10).
> > I am able to connect(SLC) to the AG using Ofono. After connection =

> I am also successful in dialing to another number.
> > Bluetoothd indicates status as "Playing" ( SCO connection =

> successful) once the call is established.
> >
> > Problem Faced:
> > ----------------------
> > However, after accepting the call I am unable to hear any voice =

> through the speaker.
> =

> You might have to loop back the PulseAudio BT source and sink to =

> your sound card, e.g.
> =

> pactl load-module module-loopback source=3D"alsa_input.pci-0000_00_1b.
> 0.analog-stereo" sink=3D"bluez_sink.78_47_1D_44_34_10"
> pactl load-module module-loopback source=3D"bluez_source.
> 78_47_1D_44_34_10" sink=3D"alsa_output.pci-0000_00_1b.0.analog-stereo"
> =

> You have to do this within 5 seconds after the SCO connection has been
> established otherwise PulseAudio will suspend (which leads to a BT
> stream stop) the streams.
> =

> HTH,
> daniel
> =

> =

> This message is for the designated recipient only and may contain =

> privileged, proprietary, or otherwise private information.  If you =

> have received it in error, please notify the sender immediately and =

> delete the original.  Any other use of the email by you is prohibited.
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Alpine Electronics R&D Europe GmbH, Vor dem Lauch 14, 70567 Stuttgart,
Registergericht Stuttgart, HRB 25265
Geschaeftsfuehrer: Hitoshi Kajiwara, Katsumi Miyake, Shigekazu Hori
Working office: Vor dem Lauch 14, 70567 Stuttgart

--===============3075235617956515151==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

Cjxicj48Zm9udCBzaXplPTIgZmFjZT0ic2Fucy1zZXJpZiI+SGkgTWlsYW4sPC9mb250Pgo8YnI+
Cjxicj48Zm9udCBzaXplPTIgZmFjZT0ic2Fucy1zZXJpZiI+SSdtIG5vdCBzdXJlIGlmIHlvdSBz
dWNjZWVkZWQgaW4gdGhlCm1lYW4gdGltZS4gPC9mb250Pgo8YnI+Cjxicj48Zm9udCBzaXplPTIg
ZmFjZT0ic2Fucy1zZXJpZiI+d2UgaGFkIGEgc2ltaWxhciBpc3N1ZSB3aGVuIHdlIHVzZWQKdGhl
IEZlZG9yYSBwcmUtaW5zdGFsbGVkIHB1bHNlYXVkaW8gdmVyc2lvbi48L2ZvbnQ+Cjxicj4KPGJy
Pjxmb250IHNpemU9MiBmYWNlPSJzYW5zLXNlcmlmIj5XaGVuIEkgZG93bmxvYWRlZCBhbmQgY29t
cGlsZWQgdGhlIGxhdGVzdApzb3VyY2VzIGl0IHdvdWtlZCBpbiBvdXIgY2FzZS4gPC9mb250Pgo8
YnI+Cjxicj48Zm9udCBzaXplPTIgZmFjZT0ic2Fucy1zZXJpZiI+UmVnYXJkcyw8L2ZvbnQ+Cjxi
cj48Zm9udCBzaXplPTIgZmFjZT0ic2Fucy1zZXJpZiI+QW5kcmVhczwvZm9udD4KPGJyPjxmb250
IHNpemU9MiBmYWNlPSJzYW5zLXNlcmlmIj4mbmJzcDs8L2ZvbnQ+Cjxicj4KPGJyPgo8YnI+PGZv
bnQgc2l6ZT0yPjx0dD5vZm9uby1ib3VuY2VzQG9mb25vLm9yZyB3cm90ZSBvbiAxMS4wMy4yMDEx
IDE1OjQzOjU5Ojxicj4KPGJyPgomZ3Q7IEhpIERhbmllbCw8YnI+CiZndDsgPGJyPgomZ3Q7IFRo
YW5rcyBmb3IgdGhlIHF1aWNrIGFzc2lzdGFuY2UuPGJyPgomZ3Q7IDxicj4KJmd0OyBJIHRyaWVk
IHRoZSBzYW1lIGFwcHJvYWNoIGFzIHN1Z2dlc3RlZCBieSB5b3UuPGJyPgomZ3Q7IDxicj4KJmd0
OyBTdGVwczo8YnI+CiZndDsgLS0tLS0tPGJyPgomZ3Q7IDEuJHBhY21kPGJyPgomZ3Q7IDIuJGxp
c3Qtc291cmNlczxicj4KJmd0OyAoIGdvdCAyIHNvdXJjZXMgKTxicj4KJmd0OyA8YnI+CiZndDsg
Jm5ic3A7IG5hbWU6ICZsdDthbHNhX291dHB1dC5wY2ktMDAwMF8wMF8wNS4wLmFuYWxvZy1zdGVy
ZW8ubW9uaXRvciZndDs8YnI+CiZndDsgPGJyPgomZ3Q7ICZuYnNwOyAoYW5kKTxicj4KJmd0OyA8
YnI+CiZndDsgJm5ic3A7IG5hbWU6ICZsdDthbHNhX2lucHV0LnBjaS0wMDAwXzAwXzA1LjAuYW5h
bG9nLXN0ZXJlbyZndDs8YnI+CiZndDsgMy4kbGlzdC1zaW5rczxicj4KJmd0OyAoIGdvdCAxIHNp
bmsgKTxicj4KJmd0OyA8YnI+CiZndDsgbmFtZTogJmx0O2Fsc2Ffb3V0cHV0LnBjaS0wMDAwXzAw
XzA1LjAuYW5hbG9nLXN0ZXJlbyZndDs8YnI+CiZndDsgPGJyPgomZ3Q7IDQuY3JlYXRlZCBhIHNo
ZWxsIHNjcmlwdCAmcXVvdDtvZm9uby5zaCZxdW90OyB3aXRoIGNvbnRlbnRzIGFzIGJlbG93Ojxi
cj4KJmd0OyBwYWN0bCBsb2FkLW1vZHVsZSBtb2R1bGUtbG9vcGJhY2sgc291cmNlPSZxdW90O2Fs
c2FfaW5wdXQucGNpLTAwMDBfMDBfMDUuPGJyPgomZ3Q7IDAuYW5hbG9nLXN0ZXJlbyZxdW90OyBz
aW5rPSZxdW90O2JsdWV6X3NpbmsuQThfN0VfMzNfQUZfMjNfQTQmcXVvdDs8YnI+CiZndDsgcGFj
dGwgbG9hZC1tb2R1bGUgbW9kdWxlLWxvb3BiYWNrIHNvdXJjZT0mcXVvdDtibHVlel9zb3VyY2Uu
PGJyPgomZ3Q7IEE4XzdFXzMzX0FGXzIzX0E0JnF1b3Q7IHNpbms9JnF1b3Q7YWxzYV9vdXRwdXQu
cGNpLTAwMDBfMDBfMDUuMC5hbmFsb2ctc3RlcmVvJnF1b3Q7PGJyPgomZ3Q7IChBOF83RV8zM19B
Rl8yM19BNCBpcyB0aGUgQlQgYWRkcmVzcyBvZiBoYW5kc2V0IHBhaXJlZCB0byB0aGUgaG9zdCk8
YnI+CiZndDsgPGJyPgomZ3Q7IDUuIE5vdyBJIGNvbm5lY3QgdGhlIGhvc3QgdG8gdGhlIGhhbmRz
ZXQgdGhyb3VnaCBIRlAuPGJyPgomZ3Q7IDYuQWZ0ZXIgU0xDIGlzIGVzdGFibGlzaGVkICwgSSBk
aWFsIGEgbnVtYmVyIGFuZCBlc3RhYmxpc2ggYSB2b2ljZQpjYWxsLjxicj4KJmd0OyA3LkFzIHNv
b24gYXMgdGhlIHN0YXRlIGlzICZxdW90O1BsYXlpbmcmcXVvdDsgKCBTQ08gY29ubmVjdGVkKSAs
IEkKcnVuIHRoZSA8YnI+CiZndDsgJnF1b3Q7b2Zvbm8uc2gmcXVvdDsgKCBhcyBtZW50aW9uZWQg
aW4gc3RlcCA0KS48YnI+CiZndDsgPGJyPgomZ3Q7IFJlc3VsdDo8YnI+CiZndDsgLS0tLS0tLTxi
cj4KJmd0OyBJIGFtIGdldHRpbmcgdGhlIGZvbGxvd2luZyBlcnJvcnM6PGJyPgomZ3Q7IDxicj4K
Jmd0OyBGYWlsdXJlOiBNb2R1bGUgaW5pdGFsaXphdGlvbiBmYWlsZWQ8YnI+CiZndDsgRmFpbHVy
ZTogTW9kdWxlIGluaXRhbGl6YXRpb24gZmFpbGVkPGJyPgomZ3Q7IDxicj4KJmd0OyA8YnI+CiZn
dDsgUmVxdWVzdGluZyBDbGFyaWZpY2F0aW9uPGJyPgomZ3Q7IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4KJmd0OyAxLkkgd2FzIHdvbmRlcmluZyBpZiBhbnkgbW9kaWZpY2F0aW9uIGlzIHJl
cXVpcmVkIGluIHB1bHNlYXVkaW8gPGJyPgomZ3Q7IGNvbmZpZ3VyYXRpb24gZmlsZXMgdG8gZW5h
YmxlIGR5bmFtaWMgbG9hZGluZyBvZiBtb2R1bGUtbG9vcGJhY2suKAo8YnI+CiZndDsgZS5nICZx
dW90O21vZHVsZS1sb2FkaW5nID0geWVzJnF1b3Q7IGluIC9ldGMvcHVsc2UvZGFlbW9uLmNvbmYg
KS5DdXJyZW50bHkKYWxsPGJyPgomZ3Q7IHNldHRpbmdzIGFyZSBtYWludGFpbmVkIGFzIGRlZmF1
bHQuPGJyPgomZ3Q7IDxicj4KJmd0OyAyLkFsc28sIGRvIEkgbmVlZCB0byBtb2RpZnkgJnF1b3Q7
U0NPUm91dGluZz1QQ00mcXVvdDsgaW4gJnF1b3Q7YXVkaW8uY29uZiZxdW90OwpmaWxlLiA8YnI+
CiZndDsgKGRlZmF1bHQgaXMgSENJKTxicj4KJmd0OyA8YnI+CiZndDsgSXQgd2lsbCBiZSBvZiBn
cmVhdCBoZWxwIHRvIHJlY2VpdmUgYW55IGZ1cnRoZXIgaW5wdXRzIHJlZ2FyZGluZyB0aGU8YnI+
CiZndDsgYWJvdmUgaXNzdWUuPGJyPgomZ3Q7IDxicj4KJmd0OyBCZXN0IFJlZ2FyZHMsPGJyPgom
Z3Q7IE1pbGFuPGJyPgomZ3Q7IDxicj4KJmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLTxi
cj4KJmd0OyBGcm9tOiBEYW5pZWwgV2FnbmVyIFttYWlsdG86d2FnaUBtb25vbS5vcmddPGJyPgom
Z3Q7IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTEsIDIwMTEgMTI6NTIgUE08YnI+CiZndDsgVG86IFNh
dHBhdGh5LCBNaWxhbjxicj4KJmd0OyBDYzogb2Zvbm9Ab2Zvbm8ub3JnPGJyPgomZ3Q7IFN1Ympl
Y3Q6IFJlOiBbSEVMUCBSZXF1aXJlZF1Sb3V0aW5nIE9mIFNDTyBkYXRhIHRvIEJUIEhvc3QgU3Bl
YWtlcjxicj4KJmd0OyA8YnI+CiZndDsgSGkgTWlsYW4sPGJyPgomZ3Q7IDxicj4KJmd0OyBPbiBG
cmksIE1hciAxMSwgMjAxMSBhdCAxMDo1NjozNEFNICswNTMwLCBtaWxhbi5zYXRwYXRoeUBhY2Nl
bnR1cmUuY29tCndyb3RlOjxicj4KJmd0OyAmZ3Q7IEhpLDxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7
ICZndDsgUmVjZW50bHkgSSBoYXZlIGJlZW4gdHJ5aW5nIHRvIHVzZSBPZm9ubyB0byB3cml0ZSBh
IEhhbmRzZnJlZQo8YnI+CiZndDsgYmFzZWQgYXBwbGljYXRpb24oIFVzaW5nIEMgb24gVWJ1bnR1
IDEwLjEwKS48YnI+CiZndDsgJmd0OyBJIGFtIGFibGUgdG8gY29ubmVjdChTTEMpIHRvIHRoZSBB
RyB1c2luZyBPZm9uby4gQWZ0ZXIgY29ubmVjdGlvbgo8YnI+CiZndDsgSSBhbSBhbHNvIHN1Y2Nl
c3NmdWwgaW4gZGlhbGluZyB0byBhbm90aGVyIG51bWJlci48YnI+CiZndDsgJmd0OyBCbHVldG9v
dGhkIGluZGljYXRlcyBzdGF0dXMgYXMgJnF1b3Q7UGxheWluZyZxdW90OyAoIFNDTyBjb25uZWN0
aW9uCjxicj4KJmd0OyBzdWNjZXNzZnVsKSBvbmNlIHRoZSBjYWxsIGlzIGVzdGFibGlzaGVkLjxi
cj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgUHJvYmxlbSBGYWNlZDo8YnI+CiZndDsgJmd0OyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgomZ3Q7ICZndDsgSG93ZXZlciwgYWZ0ZXIgYWNjZXB0
aW5nIHRoZSBjYWxsIEkgYW0gdW5hYmxlIHRvIGhlYXIgYW55IHZvaWNlCjxicj4KJmd0OyB0aHJv
dWdoIHRoZSBzcGVha2VyLjxicj4KJmd0OyA8YnI+CiZndDsgWW91IG1pZ2h0IGhhdmUgdG8gbG9v
cCBiYWNrIHRoZSBQdWxzZUF1ZGlvIEJUIHNvdXJjZSBhbmQgc2luayB0byA8YnI+CiZndDsgeW91
ciBzb3VuZCBjYXJkLCBlLmcuPGJyPgomZ3Q7IDxicj4KJmd0OyBwYWN0bCBsb2FkLW1vZHVsZSBt
b2R1bGUtbG9vcGJhY2sgc291cmNlPSZxdW90O2Fsc2FfaW5wdXQucGNpLTAwMDBfMDBfMWIuPGJy
PgomZ3Q7IDAuYW5hbG9nLXN0ZXJlbyZxdW90OyBzaW5rPSZxdW90O2JsdWV6X3NpbmsuNzhfNDdf
MURfNDRfMzRfMTAmcXVvdDs8YnI+CiZndDsgcGFjdGwgbG9hZC1tb2R1bGUgbW9kdWxlLWxvb3Bi
YWNrIHNvdXJjZT0mcXVvdDtibHVlel9zb3VyY2UuPGJyPgomZ3Q7IDc4XzQ3XzFEXzQ0XzM0XzEw
JnF1b3Q7IHNpbms9JnF1b3Q7YWxzYV9vdXRwdXQucGNpLTAwMDBfMDBfMWIuMC5hbmFsb2ctc3Rl
cmVvJnF1b3Q7PGJyPgomZ3Q7IDxicj4KJmd0OyBZb3UgaGF2ZSB0byBkbyB0aGlzIHdpdGhpbiA1
IHNlY29uZHMgYWZ0ZXIgdGhlIFNDTyBjb25uZWN0aW9uIGhhcwpiZWVuPGJyPgomZ3Q7IGVzdGFi
bGlzaGVkIG90aGVyd2lzZSBQdWxzZUF1ZGlvIHdpbGwgc3VzcGVuZCAod2hpY2ggbGVhZHMgdG8g
YSBCVDxicj4KJmd0OyBzdHJlYW0gc3RvcCkgdGhlIHN0cmVhbXMuPGJyPgomZ3Q7IDxicj4KJmd0
OyBIVEgsPGJyPgomZ3Q7IGRhbmllbDxicj4KJmd0OyA8YnI+CiZndDsgPGJyPgomZ3Q7IFRoaXMg
bWVzc2FnZSBpcyBmb3IgdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50IG9ubHkgYW5kIG1heSBjb250
YWluCjxicj4KJmd0OyBwcml2aWxlZ2VkLCBwcm9wcmlldGFyeSwgb3Igb3RoZXJ3aXNlIHByaXZh
dGUgaW5mb3JtYXRpb24uICZuYnNwO0lmCnlvdSA8YnI+CiZndDsgaGF2ZSByZWNlaXZlZCBpdCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZAo8YnI+CiZn
dDsgZGVsZXRlIHRoZSBvcmlnaW5hbC4gJm5ic3A7QW55IG90aGVyIHVzZSBvZiB0aGUgZW1haWwg
YnkgeW91IGlzIHByb2hpYml0ZWQuPGJyPgomZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPGJyPgomZ3Q7IG9mb25vIG1haWxpbmcgbGlzdDxicj4KJmd0
OyBvZm9ub0BvZm9uby5vcmc8YnI+CiZndDsgaHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5m
by9vZm9ubzxicj4KPC90dD48L2ZvbnQ+Cjxicj4KPGZvbnQgc2l6ZT0iMiIgZmFjZT0iQXJpYWwi
PkFscGluZSBFbGVjdHJvbmljcyBSJmFtcDtEIEV1cm9wZSBHbWJILCBWb3IgZGVtIExhdWNoIDE0
LCA3MDU2NyBTdHV0dGdhcnQsPC9mb250Pjxicj4KPGZvbnQgc2l6ZT0iMiIgZmFjZT0iQXJpYWwi
PlJlZ2lzdGVyZ2VyaWNodCBTdHV0dGdhcnQsIEhSQiAyNTI2NTwvZm9udD48YnI+Cjxmb250IHNp
emU9IjIiIGZhY2U9IkFyaWFsIj5HZXNjaGFlZnRzZnVlaHJlcjogSGl0b3NoaSBLYWppd2FyYSwg
S2F0c3VtaSBNaXlha2UsIFNoaWdla2F6dSBIb3JpPC9mb250Pjxicj4KPGZvbnQgc2l6ZT0iMiIg
ZmFjZT0iQXJpYWwiPldvcmtpbmcgb2ZmaWNlOiBWb3IgZGVtIExhdWNoIDE0LCA3MDU2NyBTdHV0
dGdhcnQ8L2ZvbnQ+
--===============3075235617956515151==--

