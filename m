Content-Type: multipart/mixed; boundary="===============6599685640538986521=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: Re: [PATCH 2/4] plugin: Interface for using plugins that find the MNC
 lenght from the IMSI
Date: Fri, 25 Oct 2013 14:20:53 +0300
Message-ID: <CALAvx=4aF6ukkE=0beF3vK7rq4NB4h-aeu1RKfEkSLAG6n4PYw@mail.gmail.com>
In-Reply-To: <52694CD1.1000908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6599685640538986521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Alfonso,

On 24 October 2013 19:37, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Alfonso,
>
>
> On 10/24/2013 06:02 AM, Alfonso Sanchez-Beato wrote:
>
>> ---
>>   include/sim-mnclength.h | 45 ++++++++++++++++++++++++++++++**
>> +++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 include/sim-mnclength.h
>>
>> diff --git a/include/sim-mnclength.h b/include/sim-mnclength.h
>> new file mode 100644
>> index 0000000..67769f2
>> --- /dev/null
>> +++ b/include/sim-mnclength.h
>> @@ -0,0 +1,45 @@
>> +/*
>> + *
>> + *  oFono - Open Telephony stack for Linux
>> + *
>> + *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
>>
>
> Copy-pasting?
>
>
>  + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>>  02110-1301  USA
>> + *
>> + */
>> +
>> +#ifndef OFONO_SIM_MNCLENGTH_H
>> +#define OFONO_SIM_MNCLENGTH_H
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +
>> +struct ofono_sim_mnclength_driver {
>> +       const char *name;
>> +       int (*get_mnclength)(const char *imsi);
>> +};
>> +
>> +int ofono_sim_mnclength_driver_**register(
>> +                       struct ofono_sim_mnclength_driver *driver);
>> +void ofono_sim_mnclength_driver_**unregister(
>> +                       const struct ofono_sim_mnclength_driver *driver);
>> +
>>
>
> I'd actually like to keep this out of the core API for now.  Can you make
> this plugin a 'utility' plugin similar to plugins/mbpi.[ch]?
>
> Feel free to extend provisioning API with a IMSI method for cases where
> EFad is not specifying the length.


Hopefully I'm not interfering too much but could the call to mnc plugin be
made from __ofono_gprs_provision_get_settings in gprs-provisioning.c as
there is a check for missing mnc and adding new interface to
gprs-provision.h? Would that do the trick or was this actually what you
mean?


>
>
>  +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* OFONO_SIM_MNCLENGTH_H */
>>
>>
> Regards,
> -Denis
>
> ______________________________**_________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/**mailman/listinfo/ofono<https://lists.ofono.org/=
mailman/listinfo/ofono>
>

Br,
Jarko

--===============6599685640538986521==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkhpIERlbmlzIGFuZCBBbGZv
bnNvLDxicj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIDI0IE9jdG9iZXIg
MjAxMyAxOTozNywgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1h
aWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29t
PC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtwYWRkaW5nLWxlZnQ6MWV4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQs
MjA0LDIwNCk7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkIiBj
bGFzcz0iZ21haWxfcXVvdGUiPkhpIEFsZm9uc28sPGRpdiBjbGFzcz0iaW0iPjxicj4KPGJyPgpP
biAxMC8yNC8yMDEzIDA2OjAyIEFNLCBBbGZvbnNvIFNhbmNoZXotQmVhdG8gd3JvdGU6PGJyPgo8
YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O3BhZGRpbmctbGVmdDox
ZXg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC13aWR0aDox
cHg7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQiIGNsYXNzPSJnbWFpbF9xdW90ZSI+Ci0tLTxicj4K
oCBpbmNsdWRlL3NpbS1tbmNsZW5ndGguaCB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKzx1PjwvdT4rKysrKysrKysrKysrKys8YnI+CqAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2Vy
dGlvbnMoKyk8YnI+CqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc2ltLW1uY2xlbmd0aC5o
PGJyPgo8YnI+CmRpZmYgLS1naXQgYS9pbmNsdWRlL3NpbS1tbmNsZW5ndGguaCBiL2luY2x1ZGUv
c2ltLW1uY2xlbmd0aC5oPGJyPgpuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4KaW5kZXggMDAwMDAw
MC4uNjc3NjlmMjxicj4KLS0tIC9kZXYvbnVsbDxicj4KKysrIGIvaW5jbHVkZS9zaW0tbW5jbGVu
Z3RoLmg8YnI+CkBAIC0wLDAgKzEsNDUgQEA8YnI+CisvKjxicj4KKyAqPGJyPgorICogoG9Gb25v
IC0gT3BlbiBUZWxlcGhvbnkgc3RhY2sgZm9yIExpbnV4PGJyPgorICo8YnI+CisgKiCgQ29weXJp
Z2h0IChDKSAyMDExIKBOb2tpYSBDb3Jwb3JhdGlvbiBhbmQvb3IgaXRzIHN1YnNpZGlhcnkoLWll
cykuPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KQ29weS1wYXN0aW5nPzxkaXY+PGRpdiBj
bGFzcz0iaDUiPjxicj4KPGJyPgo8YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O3BhZGRpbmctbGVmdDoxZXg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0
KTtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQiIGNsYXNzPSJn
bWFpbF9xdW90ZSI+CisgKjxicj4KKyAqIKBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
eW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeTxicj4KKyAqIKBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhczxi
cj4KKyAqIKBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi48YnI+Cisg
Kjxicj4KKyAqIKBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCw8YnI+CisgKiCgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2Y8YnI+CisgKiCgTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiCgU2VlIHRoZTxicj4KKyAqIKBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4KKyAqPGJyPgor
ICogoFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlPGJyPgorICogoGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdy
aXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlPGJyPgorICogoEZvdW5kYXRpb24sIEluYy4sIDUxIEZy
YW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSCgMDIxMTAtMTMwMSCgVVNBPGJyPgor
ICo8YnI+CisgKi88YnI+Cis8YnI+CisjaWZuZGVmIE9GT05PX1NJTV9NTkNMRU5HVEhfSDxicj4K
KyNkZWZpbmUgT0ZPTk9fU0lNX01OQ0xFTkdUSF9IPGJyPgorPGJyPgorI2lmZGVmIF9fY3BsdXNw
bHVzPGJyPgorZXh0ZXJuICZxdW90O0MmcXVvdDsgezxicj4KKyNlbmRpZjxicj4KKzxicj4KKzxi
cj4KK3N0cnVjdCBvZm9ub19zaW1fbW5jbGVuZ3RoX2RyaXZlciB7PGJyPgorIKAgoCCgIGNvbnN0
IGNoYXIgKm5hbWU7PGJyPgorIKAgoCCgIGludCAoKmdldF9tbmNsZW5ndGgpKGNvbnN0IGNoYXIg
Kmltc2kpOzxicj4KK307PGJyPgorPGJyPgoraW50IG9mb25vX3NpbV9tbmNsZW5ndGhfZHJpdmVy
Xzx1PjwvdT5yZWdpc3Rlcig8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHN0cnVjdCBvZm9u
b19zaW1fbW5jbGVuZ3RoX2RyaXZlciAqZHJpdmVyKTs8YnI+Cit2b2lkIG9mb25vX3NpbV9tbmNs
ZW5ndGhfZHJpdmVyXzx1PjwvdT51bnJlZ2lzdGVyKDxicj4KKyCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgY29uc3Qgc3RydWN0IG9mb25vX3NpbV9tbmNsZW5ndGhfZHJpdmVyICpkcml2ZXIpOzxicj4K
Kzxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+PC9kaXY+CkkmIzM5O2QgYWN0dWFsbHkgbGlr
ZSB0byBrZWVwIHRoaXMgb3V0IG9mIHRoZSBjb3JlIEFQSSBmb3Igbm93LiCgQ2FuIHlvdSBtYWtl
IHRoaXMgcGx1Z2luIGEgJiMzOTt1dGlsaXR5JiMzOTsgcGx1Z2luIHNpbWlsYXIgdG8gcGx1Z2lu
cy9tYnBpLltjaF0/PGJyPgo8YnI+CkZlZWwgZnJlZSB0byBleHRlbmQgcHJvdmlzaW9uaW5nIEFQ
SSB3aXRoIGEgSU1TSSBtZXRob2QgZm9yIGNhc2VzIHdoZXJlIEVGYWQgaXMgbm90IHNwZWNpZnlp
bmcgdGhlIGxlbmd0aC48L2Jsb2NrcXVvdGU+PGRpdj6gPC9kaXY+PGRpdj5Ib3BlZnVsbHkgSSYj
Mzk7bSBub3QgaW50ZXJmZXJpbmcgdG9vIG11Y2ggYnV0oGNvdWxkIHRoZSBjYWxsIHRvIG1uYyBw
bHVnaW4gYmUgbWFkZaBmcm9tIF9fb2Zvbm9fZ3Byc19wcm92aXNpb25fZ2V0X3NldHRpbmdzIGlu
IGdwcnMtcHJvdmlzaW9uaW5nLmMgYXMgdGhlcmUgaXMgYSBjaGVjayBmb3IgbWlzc2luZyBtbmMg
YW5kIGFkZGluZyBuZXcgaW50ZXJmYWNlIHRvIGdwcnMtcHJvdmlzaW9uLmg/IFdvdWxkIHRoYXQg
ZG8gdGhlIHRyaWNrIG9yIHdhcyB0aGlzIGFjdHVhbGx5IHdoYXQgeW91IG1lYW4/PC9kaXY+Cjxk
aXY+oDwvZGl2PjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7cGFk
ZGluZy1sZWZ0OjFleDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1s
ZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1zdHlsZTpzb2xpZCIgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48ZGl2IGNsYXNzPSJpbSI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7cGFkZGluZy1sZWZ0OjFleDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0
LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1zdHlsZTpzb2xpZCIg
Y2xhc3M9ImdtYWlsX3F1b3RlIj4KKzxicj4KKyNpZmRlZiBfX2NwbHVzcGx1czxicj4KK308YnI+
CisjZW5kaWY8YnI+Cis8YnI+CisjZW5kaWYgLyogT0ZPTk9fU0lNX01OQ0xFTkdUSF9IICovPGJy
Pgo8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PgpSZWdhcmRzLDxicj4KLURlbmlzPGRpdj48
ZGl2IGNsYXNzPSJoNSI+PGJyPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX188dT48L3U+
X19fX19fX19fX19fX19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFp
bHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48
YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zv
bm8iIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy88dT48L3U+bWFpbG1h
bi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPkJyLDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4
dHJhIj5KYXJrbzwvZGl2PjwvZGl2Pgo=

--===============6599685640538986521==--

