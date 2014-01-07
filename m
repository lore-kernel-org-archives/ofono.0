Content-Type: multipart/mixed; boundary="===============1695899416463724180=="
MIME-Version: 1.0
From: Ignazio Chiappone <gnz.chp@gmail.com>
Subject: Re: oFono issue: Reject SCO: Agent not registered
Date: Tue, 07 Jan 2014 12:56:16 -0500
Message-ID: <CANhWJ4jJ1JYbkosOkY8azspmf9gF=cgVSXZYExXye_CQ9+VP6g@mail.gmail.com>
In-Reply-To: <52CC3121.7080102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1695899416463724180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

during the last days talking with some developers of blueZ and pulseaudio,
I figured out the problem could be PA. In fact someone told me that
pulseaudio is not fully compatible with blueZ5, I mean it doesn't provide a
way to register a HandsFree Audio Agent to manage the bluetooth HFP
communication, so the chain blueZ5 -> oFono -> pulseaudio cannot work well!

I'm trying to talk with some oFono developers to understand if my previous
conclusion is correct or not, but I wasn't very lucky lately.

As far as you know are there a way to solve that problem or if exist an
anofficial version of PA that provide the support to blueZ5, oFono and so
for bluetooth HFP?

Thank you very much for your reply.

Regards,
Ignazio


2014/1/7 Denis Kenzior <denkenz@gmail.com>

> Hi Ignazio,
>
>
> On 01/03/2014 04:16 PM, Ignazio Chiappone wrote:
>
>> Hello everyone,
>>
>> my goal is to use the bluetooth HFP to make/receive a call, however I
>> have a problem with oFono.
>> Actually I'm working on Fedora 20 with blueZ 5.12 and oFono 1.14 .
>>
>> When I start ofonod I see this: http://pastebin.com/AsukjcXx .
>>
>> Using test script enable-modem, after pair my device with linux,
>> everything seems to work fine, on ofonod in debug mode, I see this:
>> http://pastebin.com/2GBmZERk .
>>
>> Now, using my device I try to make/receive a call, but I see in both
>> cases this error:
>>
>> Reject SCO: Agent not registered
>> Reject SCO: Agent not registered
>> Reject SCO: Agent not registered .
>>
>> I don't understand if that kind of problem is related to oFono or blueZ,
>> because I think it's blueZ duty to establish the SCO link, but the agent
>> reported on the error message is a particular blueZ agent or an oFono
>> agent?
>>
>
> Support for HFP actually involves 3 daemons
>
> - BlueZ5 which takes care of pairing, device detection / discovery, etc.
> - oFono which takes care of HFP protocol details and establishment of the
> SCO connection
> - PulseAudio which transmits / receives the data on the SCO link and
> "plays" it.
>
> It looks like your PulseAudio is either not installed or not the version
> that works with oFono.
>
> The oFono and BlueZ changes for HFP are currently in a 'released' state
> (e.g. part of an official release).  I'm not sure whether the PulseAudio
> changes are...
>
> Regards,
> -Denis
>

--===============1695899416463724180==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8gRGVuaXMsPGRpdj48YnI+PC9kaXY+PGRpdj5kdXJpbmcgdGhl
IGxhc3QgZGF5cyB0YWxraW5nIHdpdGggc29tZSBkZXZlbG9wZXJzIG9mIGJsdWVaIGFuZCBwdWxz
ZWF1ZGlvLCBJIGZpZ3VyZWQgb3V0IHRoZSBwcm9ibGVtIGNvdWxkIGJlIFBBLiBJbiBmYWN0IHNv
bWVvbmUgdG9sZCBtZSB0aGF0IHB1bHNlYXVkaW8gaXMgbm90IGZ1bGx5IGNvbXBhdGlibGUgd2l0
aCBibHVlWjUsIEkgbWVhbiBpdCBkb2VzbiYjMzk7dCBwcm92aWRlIGEgd2F5IHRvIHJlZ2lzdGVy
IGEgSGFuZHNGcmVlIEF1ZGlvIEFnZW50IHRvIG1hbmFnZSB0aGUgYmx1ZXRvb3RoIEhGUCBjb21t
dW5pY2F0aW9uLCBzbyB0aGUgY2hhaW4gYmx1ZVo1IC0mZ3Q7IG9Gb25vIC0mZ3Q7IHB1bHNlYXVk
aW8gY2Fubm90IHdvcmsgd2VsbCE8L2Rpdj4KCjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSB0
cnlpbmcgdG8gdGFsayB3aXRoIHNvbWUgb0Zvbm8gZGV2ZWxvcGVycyB0byB1bmRlcnN0YW5kIGlm
IG15IHByZXZpb3VzIGNvbmNsdXNpb24gaXMgY29ycmVjdCBvciBub3QsIGJ1dCBJIHdhc24mIzM5
O3QgdmVyeSBsdWNreSBsYXRlbHkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BcyBmYXIgYXMg
eW91IGtub3cgYXJlIHRoZXJlIGEgd2F5IHRvIHNvbHZlIHRoYXQgcHJvYmxlbSBvciBpZiBleGlz
dCBhbiBhbm9mZmljaWFsIHZlcnNpb24gb2YgUEEgdGhhdCBwcm92aWRlIHRoZSBzdXBwb3J0IHRv
IGJsdWVaNSwgb0Zvbm8gYW5kIHNvIGZvciBibHVldG9vdGggSEZQPzwvZGl2PgoKPGRpdj48YnI+
PC9kaXY+PGRpdj5UaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJlcGx5LjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2PklnbmF6aW88L2Rpdj48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAx
NC8xLzcgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpk
ZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZn
dDs8L3NwYW4+PGJyPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+SGkgSWduYXppbyw8ZGl2IGNsYXNzPSJpbSI+PGJyPgo8YnI+Ck9uIDAxLzAzLzIwMTQgMDQ6
MTYgUE0sIElnbmF6aW8gQ2hpYXBwb25lIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhlbGxvIGV2ZXJ5b25lLDxicj4KPGJyPgpteSBnb2Fs
IGlzIHRvIHVzZSB0aGUgYmx1ZXRvb3RoIEhGUCB0byBtYWtlL3JlY2VpdmUgYSBjYWxsLCBob3dl
dmVyIEk8YnI+CmhhdmUgYSBwcm9ibGVtIHdpdGggb0Zvbm8uPGJyPgpBY3R1YWxseSBJJiMzOTtt
IHdvcmtpbmcgb24gRmVkb3JhIDIwIHdpdGggYmx1ZVogNS4xMiBhbmQgb0Zvbm8gMS4xNCAuPGJy
Pgo8YnI+CldoZW4gSSBzdGFydCBvZm9ub2QgSSBzZWUgdGhpczogPGEgaHJlZj0iaHR0cDovL3Bh
c3RlYmluLmNvbS9Bc3VramNYeCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9wYXN0ZWJpbi5jb20v
QXN1a2pjWHg8L2E+IC48YnI+Cjxicj4KVXNpbmcgdGVzdCBzY3JpcHQgZW5hYmxlLW1vZGVtLCBh
ZnRlciBwYWlyIG15IGRldmljZSB3aXRoIGxpbnV4LDxicj4KZXZlcnl0aGluZyBzZWVtcyB0byB3
b3JrIGZpbmUsIG9uIG9mb25vZCBpbiBkZWJ1ZyBtb2RlLCBJIHNlZSB0aGlzOjxicj4KPGEgaHJl
Zj0iaHR0cDovL3Bhc3RlYmluLmNvbS8yR0JtWkVSayIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9w
YXN0ZWJpbi5jb20vMkdCbVpFUms8L2E+IC48YnI+Cjxicj4KTm93LCB1c2luZyBteSBkZXZpY2Ug
SSB0cnkgdG8gbWFrZS9yZWNlaXZlIGEgY2FsbCwgYnV0IEkgc2VlIGluIGJvdGg8YnI+CmNhc2Vz
IHRoaXMgZXJyb3I6PGJyPgo8YnI+ClJlamVjdCBTQ086IEFnZW50IG5vdCByZWdpc3RlcmVkPGJy
PgpSZWplY3QgU0NPOiBBZ2VudCBub3QgcmVnaXN0ZXJlZDxicj4KUmVqZWN0IFNDTzogQWdlbnQg
bm90IHJlZ2lzdGVyZWQgLjxicj4KPGJyPgpJIGRvbiYjMzk7dCB1bmRlcnN0YW5kIGlmIHRoYXQg
a2luZCBvZiBwcm9ibGVtIGlzIHJlbGF0ZWQgdG8gb0Zvbm8gb3IgYmx1ZVosPGJyPgpiZWNhdXNl
IEkgdGhpbmsgaXQmIzM5O3MgYmx1ZVogZHV0eSB0byBlc3RhYmxpc2ggdGhlIFNDTyBsaW5rLCBi
dXQgdGhlIGFnZW50PGJyPgpyZXBvcnRlZCBvbiB0aGUgZXJyb3IgbWVzc2FnZSBpcyBhIHBhcnRp
Y3VsYXIgYmx1ZVogYWdlbnQgb3IgYW4gb0Zvbm8gYWdlbnQ/PGJyPgo8L2Jsb2NrcXVvdGU+Cjxi
cj48L2Rpdj4KU3VwcG9ydCBmb3IgSEZQIGFjdHVhbGx5IGludm9sdmVzIDMgZGFlbW9uczxicj4K
PGJyPgotIEJsdWVaNSB3aGljaCB0YWtlcyBjYXJlIG9mIHBhaXJpbmcsIGRldmljZSBkZXRlY3Rp
b24gLyBkaXNjb3ZlcnksIGV0Yy48YnI+Ci0gb0Zvbm8gd2hpY2ggdGFrZXMgY2FyZSBvZiBIRlAg
cHJvdG9jb2wgZGV0YWlscyBhbmQgZXN0YWJsaXNobWVudCBvZiB0aGUgU0NPIGNvbm5lY3Rpb248
YnI+Ci0gUHVsc2VBdWRpbyB3aGljaCB0cmFuc21pdHMgLyByZWNlaXZlcyB0aGUgZGF0YSBvbiB0
aGUgU0NPIGxpbmsgYW5kICZxdW90O3BsYXlzJnF1b3Q7IGl0Ljxicj4KPGJyPgpJdCBsb29rcyBs
aWtlIHlvdXIgUHVsc2VBdWRpbyBpcyBlaXRoZXIgbm90IGluc3RhbGxlZCBvciBub3QgdGhlIHZl
cnNpb24gdGhhdCB3b3JrcyB3aXRoIG9Gb25vLjxicj4KPGJyPgpUaGUgb0Zvbm8gYW5kIEJsdWVa
IGNoYW5nZXMgZm9yIEhGUCBhcmUgY3VycmVudGx5IGluIGEgJiMzOTtyZWxlYXNlZCYjMzk7IHN0
YXRlIChlLmcuIHBhcnQgb2YgYW4gb2ZmaWNpYWwgcmVsZWFzZSkuIKBJJiMzOTttIG5vdCBzdXJl
IHdoZXRoZXIgdGhlIFB1bHNlQXVkaW8gY2hhbmdlcyBhcmUuLi48YnI+Cjxicj4KUmVnYXJkcyw8
YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============1695899416463724180==--

