Content-Type: multipart/mixed; boundary="===============0802225628589394914=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 14:43:29 +0100
Message-ID: <CAAs3wMhyF+AH8PuoaDb5_eVjDSuGmGLv87ccD+Wn6yZDXGDZQQ@mail.gmail.com>
In-Reply-To: <CAAs3wMgDDkOU7L8Po8CQ5upCBrjxN6a0D_KZ_wCJ0A2o2serXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0802225628589394914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sorry did not over the mail....

about ppp , Is that normal that I have to config these parameters?

4) SMS seems to work properly.

Thanks again for you precious help.



2013/3/28 Freedreamer <freedreamer@email.it>

> Hi again Denis..
> so , I have now something  that seems to work properly also when SIM is
> removed/ inserted.
>
> here a the code I've been using;
>
> http://pastebin.com/8VgKrYur
>
> Got as always some question :)
>
> 1) The "set_online" function I copied from other drivers but is not never
> called anyway...i'll tell more..if I enable it the ofono core stucks
> somewhere..:|
> 2) seems that if  I set the same virtual com for the service "dev_info"  &
> "sim"  I got a  crash of the stack...so i put them in 2 different channel
> of the Mux.
> 3) ppp works only if when I got DNS & ip
>      ifconfig ppp0  <ip>  up
>      route add -net 0.0.0.0 ppp0
>
>
>
>
> 2013/3/27 Denis Kenzior <denkenz@gmail.com>
>
>> Hi Marco,
>>
>>
>>
>>>     enable -> pre_sim, sim_inserted -> post_sim, set_online ->
>>>     post_online.  Generally you do not call set_online before hitting
>>>     the post_sim state.
>>>
>>>
>>> could I don't  implement set_online if I don't need it?
>>>
>>
>> That would work, if the modem driver does not implement set_online, oFono
>> core automatically transitions to Online after CPIN returns 'READY'.
>>
>>
>>
>>>     <snip>
>>>
>>>
>>>
>>>         I've managing vendor URC for sim detection right now but i have
>>>         problems.For instance if I remove it when ofonod is ready the
>>> Hilonc
>>>         sends an URC to notify sim status changed but after that it
>>> reboots
>>>         itself(2 sec later)... what i did is to notify the stack that
>>>         the SIM
>>>         has been removed and modem is powered off . I thought that after
>>>         calling
>>>         set_powered fnc the stack should have called my driver virtual
>>>         disable
>>>         function in order to properly close the MUX .. but it's not..
>>>
>>>
>>>     No, if you call ofono_modem_set_powered(modem, FALSE) it assumes
>>>     that the modem powered off due to an internally generated event
>>>     (e.g. not oFono's doing).  The driver has to clean up properly in
>>>     this case.  The driver disable() method is only called on oFono
>>>     initiated power down requests.
>>>
>>>
>>> mmh ok..so If the modem restarts it's my business to disable and enable
>>> again all the driver' stuff , right?
>>>
>>>
>> If the modem resets, then yes you need to call ofono_modem_set_powered to
>> FALSE.  Booting it back up should not be done in the driver, unless your
>> modem supports so called silent resets.  This is where the modem stack
>> crashes but silently resets itself back to the previous state. (e.g. no =
PIN
>> entry is required, initialization is very fast). In that case use
>> ofono_modem_reset.
>>
>> <snip>
>>
>> Glad I could help ;)
>>
>> Regards,
>> -Denis
>>
>
>

--===============0802225628589394914==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

c29ycnkgZGlkIG5vdCBvdmVyIHRoZSBtYWlsLi4uLjxicj48YnI+YWJvdXQgcHBwICwgSXMgdGhh
dCBub3JtYWwgdGhhdCBJIGhhdmUgdG8gY29uZmlnIHRoZXNlIHBhcmFtZXRlcnM/PGJyPjxicj40
KSBTTVMgc2VlbXMgdG8gd29yayBwcm9wZXJseS48YnI+PGJyPlRoYW5rcyBhZ2FpbiBmb3IgeW91
IHByZWNpb3VzIGhlbHAuPGJyPjxicj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4K
MjAxMy8zLzI4IEZyZWVkcmVhbWVyIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRv
OmZyZWVkcmVhbWVyQGVtYWlsLml0IiB0YXJnZXQ9Il9ibGFuayI+ZnJlZWRyZWFtZXJAZW1haWwu
aXQ8L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+CkhpIGFnYWluIERlbmlzLi48YnI+c28gLCBJIGhhdmUgbm93IHNvbWV0aGluZ6Ag
dGhhdCBzZWVtcyB0byB3b3JrIHByb3Blcmx5IGFsc28gd2hlbiBTSU0gaXMgcmVtb3ZlZC8gaW5z
ZXJ0ZWQuPGJyPjxicj5oZXJlIGEgdGhlIGNvZGUgSSYjMzk7dmUgYmVlbiB1c2luZzs8YnI+PGJy
PjxhIGhyZWY9Imh0dHA6Ly9wYXN0ZWJpbi5jb20vOFZnS3JZdXIiIHRhcmdldD0iX2JsYW5rIj5o
dHRwOi8vcGFzdGViaW4uY29tLzhWZ0tyWXVyPC9hPjxicj4KCjxicj5Hb3QgYXMgYWx3YXlzIHNv
bWUgcXVlc3Rpb24gOik8YnI+PGJyPjEpIFRoZSAmcXVvdDtzZXRfb25saW5lJnF1b3Q7IGZ1bmN0
aW9uIEkgY29waWVkIGZyb20gb3RoZXIgZHJpdmVycyBidXQgaXMgbm90IG5ldmVyIGNhbGxlZCBh
bnl3YXkuLi5pJiMzOTtsbCB0ZWxsIG1vcmUuLmlmIEkgZW5hYmxlIGl0IHRoZSBvZm9ubyBjb3Jl
IHN0dWNrcyBzb21ld2hlcmUuLjp8PGJyPjIpIHNlZW1zIHRoYXQgaWagIEkgc2V0IHRoZSBzYW1l
IHZpcnR1YWwgY29tIGZvciB0aGUgc2VydmljZSAmcXVvdDtkZXZfaW5mbyZxdW90O6AgJmFtcDsg
JnF1b3Q7c2ltJnF1b3Q7oCBJIGdvdCBhoCBjcmFzaCBvZiB0aGUgc3RhY2suLi5zbyBpIHB1dCB0
aGVtIGluIDIgZGlmZmVyZW50IGNoYW5uZWwgb2YgdGhlIE11eC48YnI+CgozKSBwcHAgd29ya3Mg
b25seSBpZiB3aGVuIEkgZ290IEROUyAmYW1wOyBpcCA8YnI+oKCgoCBpZmNvbmZpZyBwcHAwoCAm
bHQ7aXAmZ3Q7oCB1cDxicj6goKCgIHJvdXRlIGFkZCAtbmV0IDAuMC4wLjAgcHBwMDxkaXYgY2xh
c3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj48YnI+PGJyPjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+MjAxMy8zLzI3IERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56
QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj4KCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPkhpIE1hcmNvLDxkaXY+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFw
eCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CqAgoCBlbmFibGUgLSZndDsgcHJl
X3NpbSwgc2ltX2luc2VydGVkIC0mZ3Q7IHBvc3Rfc2ltLCBzZXRfb25saW5lIC0mZ3Q7PGJyPgqg
IKAgcG9zdF9vbmxpbmUuIKBHZW5lcmFsbHkgeW91IGRvIG5vdCBjYWxsIHNldF9vbmxpbmUgYmVm
b3JlIGhpdHRpbmc8YnI+CqAgoCB0aGUgcG9zdF9zaW0gc3RhdGUuPGJyPgo8YnI+Cjxicj4KY291
bGQgSSBkb24mIzM5O3QgoGltcGxlbWVudCBzZXRfb25saW5lIGlmIEkgZG9uJiMzOTt0IG5lZWQg
aXQ/PGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KVGhhdCB3b3VsZCB3b3JrLCBpZiB0aGUg
bW9kZW0gZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCBzZXRfb25saW5lLCBvRm9ubyBjb3JlIGF1
dG9tYXRpY2FsbHkgdHJhbnNpdGlvbnMgdG8gT25saW5lIGFmdGVyIENQSU4gcmV0dXJucyAmIzM5
O1JFQURZJiMzOTsuPGRpdj48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+Cjxicj4KoCCgICZsdDtzbmlwJmd0Ozxicj4KPGJyPgo8YnI+Cjxicj4K
oCCgIKAgoCBJJiMzOTt2ZSBtYW5hZ2luZyB2ZW5kb3IgVVJDIGZvciBzaW0gZGV0ZWN0aW9uIHJp
Z2h0IG5vdyBidXQgaSBoYXZlPGJyPgqgIKAgoCCgIHByb2JsZW1zLkZvciBpbnN0YW5jZSBpZiBJ
IHJlbW92ZSBpdCB3aGVuIG9mb25vZCBpcyByZWFkeSB0aGUgSGlsb25jPGJyPgqgIKAgoCCgIHNl
bmRzIGFuIFVSQyB0byBub3RpZnkgc2ltIHN0YXR1cyBjaGFuZ2VkIGJ1dCBhZnRlciB0aGF0IGl0
IHJlYm9vdHM8YnI+CqAgoCCgIKAgaXRzZWxmKDIgc2VjIGxhdGVyKS4uLiB3aGF0IGkgZGlkIGlz
IHRvIG5vdGlmeSB0aGUgc3RhY2sgdGhhdDxicj4KoCCgIKAgoCB0aGUgU0lNPGJyPgqgIKAgoCCg
IGhhcyBiZWVuIHJlbW92ZWQgYW5kIG1vZGVtIGlzIHBvd2VyZWQgb2ZmIC4gSSB0aG91Z2h0IHRo
YXQgYWZ0ZXI8YnI+CqAgoCCgIKAgY2FsbGluZzxicj4KoCCgIKAgoCBzZXRfcG93ZXJlZCBmbmMg
dGhlIHN0YWNrIHNob3VsZCBoYXZlIGNhbGxlZCBteSBkcml2ZXIgdmlydHVhbDxicj4KoCCgIKAg
oCBkaXNhYmxlPGJyPgqgIKAgoCCgIGZ1bmN0aW9uIGluIG9yZGVyIHRvIHByb3Blcmx5IGNsb3Nl
IHRoZSBNVVggLi4gYnV0IGl0JiMzOTtzIG5vdC4uPGJyPgo8YnI+Cjxicj4KoCCgIE5vLCBpZiB5
b3UgY2FsbCBvZm9ub19tb2RlbV9zZXRfcG93ZXJlZChtb2RlbSwgRkFMU0UpIGl0IGFzc3VtZXM8
YnI+CqAgoCB0aGF0IHRoZSBtb2RlbSBwb3dlcmVkIG9mZiBkdWUgdG8gYW4gaW50ZXJuYWxseSBn
ZW5lcmF0ZWQgZXZlbnQ8YnI+CqAgoCAoZS5nLiBub3Qgb0Zvbm8mIzM5O3MgZG9pbmcpLiCgVGhl
IGRyaXZlciBoYXMgdG8gY2xlYW4gdXAgcHJvcGVybHkgaW48YnI+CqAgoCB0aGlzIGNhc2UuIKBU
aGUgZHJpdmVyIGRpc2FibGUoKSBtZXRob2QgaXMgb25seSBjYWxsZWQgb24gb0Zvbm88YnI+CqAg
oCBpbml0aWF0ZWQgcG93ZXIgZG93biByZXF1ZXN0cy48YnI+Cjxicj4KPGJyPgptbWggb2suLnNv
IElmIHRoZSBtb2RlbSByZXN0YXJ0cyBpdCYjMzk7cyBteSBidXNpbmVzcyB0byBkaXNhYmxlIGFu
ZCBlbmFibGU8YnI+CmFnYWluIGFsbCB0aGUgZHJpdmVyJiMzOTsgc3R1ZmYgLCByaWdodD88YnI+
Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+CklmIHRoZSBtb2RlbSByZXNldHMsIHRoZW4g
eWVzIHlvdSBuZWVkIHRvIGNhbGwgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQgdG8gRkFMU0UuIKBC
b290aW5nIGl0IGJhY2sgdXAgc2hvdWxkIG5vdCBiZSBkb25lIGluIHRoZSBkcml2ZXIsIHVubGVz
cyB5b3VyIG1vZGVtIHN1cHBvcnRzIHNvIGNhbGxlZCBzaWxlbnQgcmVzZXRzLiCgVGhpcyBpcyB3
aGVyZSB0aGUgbW9kZW0gc3RhY2sgY3Jhc2hlcyBidXQgc2lsZW50bHkgcmVzZXRzIGl0c2VsZiBi
YWNrIHRvIHRoZSBwcmV2aW91cyBzdGF0ZS4gKGUuZy4gbm8gUElOIGVudHJ5IGlzIHJlcXVpcmVk
LCBpbml0aWFsaXphdGlvbiBpcyB2ZXJ5IGZhc3QpLiBJbiB0aGF0IGNhc2UgdXNlIG9mb25vX21v
ZGVtX3Jlc2V0Ljxicj4KCgo8YnI+CiZsdDtzbmlwJmd0Ozxicj4KPGJyPgpHbGFkIEkgY291bGQg
aGVscCA7KTxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9k
aXY+PGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============0802225628589394914==--

