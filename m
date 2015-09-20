Content-Type: multipart/mixed; boundary="===============8140940406798585360=="
MIME-Version: 1.0
From: Jason Gauthier <jagauthier@gmail.com>
Subject: Re: Hands Free/Pulse - not working well
Date: Sun, 20 Sep 2015 14:17:15 -0400
Message-ID: <CAHY_EhVZPs5G9csjr8qEoqEDzO_T6DXr0KZa+6O_X6WABKMQQw@mail.gmail.com>
In-Reply-To: <55FD6A44.8070000@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8140940406798585360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Georg,

 Thanks for your response.  I've never heard of that option before, so I
added it.  Up until this point, I've been just trying to figure it out.
I've not found any documentation on how to accomplish this.

So, I added that parameter. My results are similiar to results I've
achieved before.  No crashing this time.  (But it's not 100% reliable
either).

I placed one call, and everything worked (audio in out of the computer).
I've been able to get this to happen once in a while.
I disconnect the call from the phone.   I placed a second call, there
wasn't any audio, and my logs scroll like this:
[ 1052.809382] Bluetooth: hci0 SCO packet for unknown connection handle 2
[ 1052.809964] Bluetooth: hci0 SCO packet for unknown connection handle
16384
[ 1052.810563] Bluetooth: hci0 SCO packet for unknown connection handle 48
[ 1052.811371] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.811982] Bluetooth: hci0 SCO packet for unknown connection handle 256
[ 1052.812581] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.813378] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.813968] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.814712] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.815681] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.816536] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.817712] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.818544] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.819508] Bluetooth: hci0 SCO packet for unknown connection handle 1
[ 1052.820332] Bluetooth: hci0 SCO packet for unknown connection handle 1

I disconnected that call. I placed a third call and all audio came out of
the phone.
In a few previous tests, when this happens I see that ofono still thinks I
have a voicecall.
So, I probed dbus to verify this:
qdbus --system org.ofono

As soon as I did that, the VM shut off. (No kernel crash - just instant off
- I've seen this a few times)



On Sat, Sep 19, 2015 at 9:59 AM, Georg Chini <georg@chini.tk> wrote:

> On 18.09.2015 20:01, Jason Gauthier wrote:
>
>> Greetings,
>>
>>       I've been working on getting a HFP working with bluez and
>> pulseaudio.  I'm running into an assortment of issues- I don't even know
>> where to begin!
>>
>> To set the stage, I'm running the latest version of bluez (5.33)
>> pulseaudio (6.0) and ofono
>> (pulled out of git). I've compiled everything from source.
>>
>> Using PA and Bluez, I have audio sink working.  So I've verified several
>> components at this point.
>> I can connect the HFP.  Once I start making calls, is when things start
>> to fall apart.
>>
>> (BTW, this happens with ofono 1.15, and 1.16 as well)
>>
>> So, as I'm writing this, the last two times after booting (debian
>> jessie), connecting, and dialing, the system reboots. I've tried looking=
 at
>> debugging the kernel crash, and I've just not got very far.
>>
>> I realize no one can tell me clearly how to fix this, I would appreciate
>> some suggestions, or ways I can continue to debug this.
>>
>> Ultimately, my goal is to put this on a raspberry pi for a car stereo. At
>> the moment, I am just trying to get a proof of concept working.
>>
>> Thanks!
>>
>> Hi Jason,
>
> do you use headset=3Dofono as parameter to module-bluetooth-discover in
> default.pa?
> Otherwise things will go wrong, although I would not expect a reboot of
> the machine.
>
> Regards
>              Georg
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============8140940406798585360==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+R2VvcmcsPGRpdj48YnI+PC9kaXY+PGRpdj7CoFRoYW5rcyBmb3IgeW91
ciByZXNwb25zZS7CoCBJJiMzOTt2ZSBuZXZlciBoZWFyZCBvZiB0aGF0IG9wdGlvbiBiZWZvcmUs
IHNvIEkgYWRkZWQgaXQuwqAgVXAgdW50aWwgdGhpcyBwb2ludCwgSSYjMzk7dmUgYmVlbiBqdXN0
IHRyeWluZyB0byBmaWd1cmUgaXQgb3V0LsKgIEkmIzM5O3ZlIG5vdCBmb3VuZCBhbnkgZG9jdW1l
bnRhdGlvbiBvbiBob3cgdG8gYWNjb21wbGlzaCB0aGlzLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+U28sIEkgYWRkZWQgdGhhdCBwYXJhbWV0ZXIuIE15IHJlc3VsdHMgYXJlIHNpbWlsaWFyIHRv
IHJlc3VsdHMgSSYjMzk7dmUgYWNoaWV2ZWQgYmVmb3JlLsKgIE5vIGNyYXNoaW5nIHRoaXMgdGlt
ZS4gwqAoQnV0IGl0JiMzOTtzIG5vdCAxMDAlIHJlbGlhYmxlIGVpdGhlcikuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5JIHBsYWNlZCBvbmUgY2FsbCwgYW5kIGV2ZXJ5dGhpbmcgd29ya2VkIChh
dWRpbyBpbiBvdXQgb2YgdGhlIGNvbXB1dGVyKS4gSSYjMzk7dmUgYmVlbiBhYmxlIHRvIGdldCB0
aGlzIHRvIGhhcHBlbiBvbmNlIGluIGEgd2hpbGUuPC9kaXY+PGRpdj5JIGRpc2Nvbm5lY3QgdGhl
IGNhbGwgZnJvbSB0aGUgcGhvbmUuIMKgIEkgcGxhY2VkIGEgc2Vjb25kIGNhbGwsIHRoZXJlIHdh
c24mIzM5O3QgYW55IGF1ZGlvLCBhbmQgbXkgbG9ncyBzY3JvbGwgbGlrZSB0aGlzOjwvZGl2Pjxk
aXY+PGRpdj5bIDEwNTIuODA5MzgyXSBCbHVldG9vdGg6IGhjaTAgU0NPIHBhY2tldCBmb3IgdW5r
bm93biBjb25uZWN0aW9uIGhhbmRsZSAyPC9kaXY+PGRpdj5bIDEwNTIuODA5OTY0XSBCbHVldG9v
dGg6IGhjaTAgU0NPIHBhY2tldCBmb3IgdW5rbm93biBjb25uZWN0aW9uIGhhbmRsZSAxNjM4NDwv
ZGl2PjxkaXY+WyAxMDUyLjgxMDU2M10gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVu
a25vd24gY29ubmVjdGlvbiBoYW5kbGUgNDg8L2Rpdj48ZGl2PlsgMTA1Mi44MTEzNzFdIEJsdWV0
b290aDogaGNpMCBTQ08gcGFja2V0IGZvciB1bmtub3duIGNvbm5lY3Rpb24gaGFuZGxlIDE8L2Rp
dj48ZGl2PlsgMTA1Mi44MTE5ODJdIEJsdWV0b290aDogaGNpMCBTQ08gcGFja2V0IGZvciB1bmtu
b3duIGNvbm5lY3Rpb24gaGFuZGxlIDI1NjwvZGl2PjxkaXY+WyAxMDUyLjgxMjU4MV0gQmx1ZXRv
b3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2
PjxkaXY+WyAxMDUyLjgxMzM3OF0gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25v
d24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAxMDUyLjgxMzk2OF0gQmx1ZXRvb3Ro
OiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2Pjxk
aXY+WyAxMDUyLjgxNDcxMl0gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24g
Y29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAxMDUyLjgxNTY4MV0gQmx1ZXRvb3RoOiBo
Y2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+
WyAxMDUyLjgxNjUzNl0gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29u
bmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAxMDUyLjgxNzcxMl0gQmx1ZXRvb3RoOiBoY2kw
IFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAx
MDUyLjgxODU0NF0gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVj
dGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAxMDUyLjgxOTUwOF0gQmx1ZXRvb3RoOiBoY2kwIFND
TyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMTwvZGl2PjxkaXY+WyAxMDUy
LjgyMDMzMl0gQmx1ZXRvb3RoOiBoY2kwIFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlv
biBoYW5kbGUgMTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBkaXNjb25uZWN0ZWQg
dGhhdCBjYWxsLiBJIHBsYWNlZCBhIHRoaXJkIGNhbGwgYW5kIGFsbCBhdWRpbyBjYW1lIG91dCBv
ZiB0aGUgcGhvbmUuPC9kaXY+PGRpdj5JbiBhIGZldyBwcmV2aW91cyB0ZXN0cywgd2hlbiB0aGlz
IGhhcHBlbnMgSSBzZWUgdGhhdCBvZm9ubyBzdGlsbCB0aGlua3MgSSBoYXZlIGEgdm9pY2VjYWxs
LiDCoDwvZGl2PjxkaXY+U28sIEkgcHJvYmVkIGRidXMgdG8gdmVyaWZ5IHRoaXM6wqA8L2Rpdj48
ZGl2PnFkYnVzIC0tc3lzdGVtIG9yZy5vZm9ubzxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkFzIHNvb24gYXMgSSBkaWQgdGhhdCwgdGhlIFZNIHNodXQgb2ZmLiAoTm8ga2VybmVsIGNyYXNo
IC0ganVzdCBpbnN0YW50IG9mZiAtIEkmIzM5O3ZlIHNlZW4gdGhpcyBhIGZldyB0aW1lcyk8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBTYXQsIFNlcCAxOSwgMjAxNSBh
dCA5OjU5IEFNLCBHZW9yZyBDaGluaSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpnZW9yZ0BjaGluaS50ayIgdGFyZ2V0PSJfYmxhbmsiPmdlb3JnQGNoaW5pLnRrPC9hPiZndDs8
L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij5PbiAxOC4wOS4yMDE1IDIwOjAxLCBKYXNvbiBHYXV0aGllciB3cm90ZTo8YnI+CjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpHcmVldGluZ3MsPGJyPgo8
YnI+CsKgIMKgIMKgIEkmIzM5O3ZlIGJlZW4gd29ya2luZyBvbiBnZXR0aW5nIGEgSEZQIHdvcmtp
bmcgd2l0aCBibHVleiBhbmQgcHVsc2VhdWRpby7CoCBJJiMzOTttIHJ1bm5pbmcgaW50byBhbiBh
c3NvcnRtZW50IG9mIGlzc3Vlcy0gSSBkb24mIzM5O3QgZXZlbiBrbm93IHdoZXJlIHRvIGJlZ2lu
ITxicj4KPGJyPgpUbyBzZXQgdGhlIHN0YWdlLCBJJiMzOTttIHJ1bm5pbmcgdGhlIGxhdGVzdCB2
ZXJzaW9uIG9mIGJsdWV6ICg1LjMzKSBwdWxzZWF1ZGlvICg2LjApIGFuZCBvZm9ubzxicj4KKHB1
bGxlZCBvdXQgb2YgZ2l0KS4gSSYjMzk7dmUgY29tcGlsZWQgZXZlcnl0aGluZyBmcm9tIHNvdXJj
ZS48YnI+Cjxicj4KVXNpbmcgUEEgYW5kIEJsdWV6LCBJIGhhdmUgYXVkaW8gc2luayB3b3JraW5n
LsKgIFNvIEkmIzM5O3ZlIHZlcmlmaWVkIHNldmVyYWwgY29tcG9uZW50cyBhdCB0aGlzIHBvaW50
Ljxicj4KSSBjYW4gY29ubmVjdCB0aGUgSEZQLsKgIE9uY2UgSSBzdGFydCBtYWtpbmcgY2FsbHMs
IGlzIHdoZW4gdGhpbmdzIHN0YXJ0IHRvIGZhbGwgYXBhcnQuPGJyPgo8YnI+CihCVFcsIHRoaXMg
aGFwcGVucyB3aXRoIG9mb25vIDEuMTUsIGFuZCAxLjE2IGFzIHdlbGwpPGJyPgo8YnI+ClNvLCBh
cyBJJiMzOTttIHdyaXRpbmcgdGhpcywgdGhlIGxhc3QgdHdvIHRpbWVzIGFmdGVyIGJvb3Rpbmcg
KGRlYmlhbiBqZXNzaWUpLCBjb25uZWN0aW5nLCBhbmQgZGlhbGluZywgdGhlIHN5c3RlbSByZWJv
b3RzLiBJJiMzOTt2ZSB0cmllZCBsb29raW5nIGF0IGRlYnVnZ2luZyB0aGUga2VybmVsIGNyYXNo
LCBhbmQgSSYjMzk7dmUganVzdCBub3QgZ290IHZlcnkgZmFyLjxicj4KPGJyPgpJIHJlYWxpemUg
bm8gb25lIGNhbiB0ZWxsIG1lIGNsZWFybHkgaG93IHRvIGZpeCB0aGlzLCBJIHdvdWxkIGFwcHJl
Y2lhdGUgc29tZSBzdWdnZXN0aW9ucywgb3Igd2F5cyBJIGNhbiBjb250aW51ZSB0byBkZWJ1ZyB0
aGlzLjxicj4KPGJyPgpVbHRpbWF0ZWx5LCBteSBnb2FsIGlzIHRvIHB1dCB0aGlzIG9uIGEgcmFz
cGJlcnJ5IHBpIGZvciBhIGNhciBzdGVyZW8uIEF0IHRoZSBtb21lbnQsIEkgYW0ganVzdCB0cnlp
bmcgdG8gZ2V0IGEgcHJvb2Ygb2YgY29uY2VwdCB3b3JraW5nLjxicj4KPGJyPgpUaGFua3MhPGJy
Pgo8YnI+CjwvYmxvY2txdW90ZT4KSGkgSmFzb24sPGJyPgo8YnI+CmRvIHlvdSB1c2UgaGVhZHNl
dD1vZm9ubyBhcyBwYXJhbWV0ZXIgdG8gbW9kdWxlLWJsdWV0b290aC1kaXNjb3ZlciBpbiA8YSBo
cmVmPSJodHRwOi8vZGVmYXVsdC5wYSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+
ZGVmYXVsdC5wYTwvYT4/PGJyPgpPdGhlcndpc2UgdGhpbmdzIHdpbGwgZ28gd3JvbmcsIGFsdGhv
dWdoIEkgd291bGQgbm90IGV4cGVjdCBhIHJlYm9vdCBvZiB0aGUgbWFjaGluZS48YnI+Cjxicj4K
UmVnYXJkczxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqBHZW9yZzxicj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxi
cj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25v
QG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxt
YW4vbGlzdGluZm8vb2Zvbm8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2Nr
cXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============8140940406798585360==--

