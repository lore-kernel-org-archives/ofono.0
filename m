Content-Type: multipart/mixed; boundary="===============0186672978953104584=="
MIME-Version: 1.0
From: wajdi zairi <wajdi.zairi@gmail.com>
Subject: Re: [OFONO][Gemalto] Sent SMS status
Date: Mon, 18 Feb 2019 15:16:38 +0100
Message-ID: <CAJTQovbm0z2u81SuJ4bf=D9k4vTH5tmwi7u8s7HPKah-HnD8AQ@mail.gmail.com>
In-Reply-To: <10642a14-441f-862a-61f0-22bd6275ea1b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0186672978953104584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for your reply !

I thought using the sms history as a driver under drivers/gemaltomodems/
but i agree with you that using as plugin will be better since it is not
specific to Gemalto modems and already designed as plugin in Examples .

Please correct me because like i understood that you don't prefer using
DBus to notify sms status while Ofono is already exposing Dbus interfaces
for methods calls or signals and built around Dbus .
I tried to keep using Dbus to signal sms reports status from added History
plugin. Signaling such status will avoid to keep saving/handling SMS
reports on Ofono side and let applications/clients handle this based on
returned SMS ID when sending .

Yes , I'm enabling Delivery Reports (*org.ofono.MessageManager.SetProperty
 string:"UseDeliveryReports" variant:boolean:"true"* )

*Here a result using proposed sms history plugin : *

Here i sent an SMS :
~#
 org.ofono.MessageManager.SendMessage string:"xxxxxx" string:"hello"o_0
method return sender=3D:1.22 -> dest=3D:1.33 reply_serial=3D2
   object path "/gemalto_0/message_9BD77FFD695EB2F234B255257C1A372D2C4582F9"


Here i monitor on added "smsStatusUpdate" member for added interface
"org.ofono.smsHistory"   (*dbus-monitor --system
"type=3D'signal',interface=3D'org.ofono.smsHistory'"  & *)


~# signal sender=3D:1.22 -> dest=3D(null destination) serial=3D1651
path=3D/gemalto_0; interface=3Dorg.ofono.smsHistory; member=3DsmsStatuse
   array [
      dict entry(
         string "SmsId"
         variant             string
"9BD77FFD695EB2F234B255257C1A372D2C4582F9"
      )
      dict entry(
         string "Status"
         variant             uint16 1             =3D>
OFONO_HISTORY_SMS_STATUS_SUBMITTED
      )
   ]
signal sender=3D:1.22 -> dest=3D(null destination) serial=3D1655 path=3D/ge=
malto_0;
interface=3Dorg.ofono.smsHistory; member=3DsmsStatusUpdate
   array [
      dict entry(
         string "SmsId"
         variant             string
"9BD77FFD695EB2F234B255257C1A372D2C4582F9"
      )
      dict entry(
         string "Status"
         variant             uint16 4        =3D>
OFONO_HISTORY_SMS_STATUS_DELIVERED
      )
   ]



*Here when using wrong number : *

# signal sender=3D:1.22 -> dest=3D(null destination) serial=3D2337
path=3D/gemalto_0; interface=3Dorg.ofono.smsHistory; member=3DsmsStatusUpda=
te
   array [
      dict entry(
         string "SmsId"
         variant             string
"63D3C903B5EED7B41D3E666CA53A3200D5E14F23"
      )
      dict entry(
         string "Status"
         variant             uint16 1
      )
   ]
signal sender=3D:1.22 -> dest=3D(null destination) serial=3D2341 path=3D/ge=
malto_0;
interface=3Dorg.ofono.smsHistory; member=3DsmsStatusUpdate
   array [
      dict entry(
         string "SmsId"
         variant             string
"63D3C903B5EED7B41D3E666CA53A3200D5E14F23"
      )
      dict entry(
         string "Status"
         variant             uint16 5   =3D>
OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED
      )
   ]


Please let me know your opinion and suggestions.

Kind Regards,
Wajdi ZAIRI
Embedded Software Engineer

Le jeu. 14 f=C3=A9vr. 2019 =C3=A0 18:07, Denis Kenzior <denkenz@gmail.com=
> a =C3=A9crit :

> Hi Wajdi,
>
> On 02/14/2019 04:49 AM, wajdi zairi wrote:
> > Hi all ,
> >
> >
> > We are planning to add a feature to handle sent SMS status . The
> > available OFONO APIs to use seems provided by *org.ofono.Message* but
> > when i made some tests
> > to catch the *PropertyChanged* signal on a sent SMS i notes that the
> > result is always "sent" (when out from TX) even on a wrong destination
> > number .
> >
>
> Can you elaborate?  If the destination number is still a valid number,
> then this wouldn't be surprising.
>
> > # signal sender=3D:1.12 -> dest=3D(null destination) serial=3D105
> > path=3D/gemalto_0/message_2F3426EAC5E3EBA365FA626347886C0EC4DC5323;
> > interface=3Dorg.ofond
> >     string "State"
> >     variant       string "sent"
> >
> > Also the call of *org.ofono.Message.GetProperties*() on given message
> > object path will fail since ofono is removing to object after sending
> > (sms_tx_queue_remove_entry) .
>
> Yes, this is expected behavior and somewhat documented in the
> messagemanager-api.txt.  However, D-Bus API is not meant to be used for
> tracking message history; in fact delivery reports are not even signaled
> via D-Bus.  This is on purpose, since we cannot easily guarantee any
> sort of reliability via any IPC mechanism, and implementing a protocol
> between a history client (using acks or other mechanisms) over D-Bus was
> deemed to be too complicated.  The history plugin is probably what you
> want.
>
> >
> > So here the "sent" means that the message was treated and out from TX
> > but does not give the real state if it was delivered or not .
> > I made a try by adding History driver to our Gemalto drivers and it
> > gives a better result regarding SMS delivery status which meet our
> > requirements.
>
> I'm guessing using status reports?
>
> >
> > To keep our ofono aligned with latest ofono updates, we want to upstream
> > our contributions so i want to get your opinion about a propasal
> > upstream candidate :
> >
> > - Add history driver implementation to drivers/gemaltomodems/
>
> Why would SMS history be specific to Gemalto modems?
>
> > - Add signal in plugins/gemalto.c  to notify the different sent messages
> > status  (indicated on enum*ofono_history_sms_status* )
> > - Then the signal can be consumed by any client after sending an SMS .
> >
>
> The reason why we don't have such an API is already covered above.
> Ideally, you want the history plugin to directly update the history in
> your database of choice, or simply call your call/sms history tracking
> service directly.  There's really no reason to broadcast this
> information via a different API.
>
> Regards,
> -Denis
>

--===============0186672978953104584==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5p
cyzCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5ICHC
oDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB0aG91Z2h0IHVzaW5nIHRoZSBzbXMgaGlzdG9y
eSBhcyBhIGRyaXZlciB1bmRlciBkcml2ZXJzL2dlbWFsdG9tb2RlbXMvIGJ1dCBpIGFncmVlIHdp
dGggeW91IHRoYXQgdXNpbmcgYXMgcGx1Z2luIHdpbGwgYmUgYmV0dGVyIHNpbmNlIGl0IGlzIG5v
dCBzcGVjaWZpYyB0byBHZW1hbHRvIG1vZGVtcyBhbmQgYWxyZWFkeSBkZXNpZ25lZCBhcyBwbHVn
aW4gaW4gRXhhbXBsZXMgLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UGxlYXNlIGNvcnJlY3Qg
bWUgYmVjYXVzZSBsaWtlIGkgdW5kZXJzdG9vZCB0aGF0IHlvdSBkb24mIzM5O3QgcHJlZmVyIHVz
aW5nIERCdXMgdG8gbm90aWZ5IHNtcyBzdGF0dXMgd2hpbGUgT2Zvbm8gaXMgYWxyZWFkeSBleHBv
c2luZyBEYnVzIGludGVyZmFjZXMgZm9yIG1ldGhvZHMgY2FsbHMgb3Igc2lnbmFscyBhbmQgYnVp
bHQgYXJvdW5kIERidXMgLjwvZGl2PjxkaXY+SSB0cmllZCB0byBrZWVwIHVzaW5nIERidXMgdG8g
c2lnbmFsIHNtcyByZXBvcnRzIHN0YXR1cyBmcm9tIGFkZGVkIEhpc3RvcnkgcGx1Z2luLiBTaWdu
YWxpbmcgc3VjaCBzdGF0dXMgd2lsbCBhdm9pZCB0byBrZWVwIHNhdmluZy9oYW5kbGluZyBTTVMg
cmVwb3J0cyBvbiBPZm9ubyBzaWRlIGFuZCBsZXQgYXBwbGljYXRpb25zL2NsaWVudHMgaGFuZGxl
IHRoaXMgYmFzZWQgb24gcmV0dXJuZWQgU01TIElEIHdoZW4gc2VuZGluZyAuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5ZZXMgLCBJJiMzOTttIGVuYWJsaW5nIERlbGl2ZXJ5IFJlcG9ydHMgKDxi
Pm9yZy5vZm9uby5NZXNzYWdlTWFuYWdlci5TZXRQcm9wZXJ0ecKgIMKgc3RyaW5nOiZxdW90O1Vz
ZURlbGl2ZXJ5UmVwb3J0cyZxdW90OyB2YXJpYW50OmJvb2xlYW46JnF1b3Q7dHJ1ZSZxdW90Ozwv
Yj4gKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGI+PHU+SGVyZSBhIHJlc3VsdCB1c2luZyBw
cm9wb3NlZCBzbXMgaGlzdG9yeSBwbHVnaW4gOsKgPC91PjwvYj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkhlcmUgaSBzZW50IGFuIFNNUyA6wqA8L2Rpdj48ZGl2Pn4jwqA8L2Rpdj48ZGl2PsKg
b3JnLm9mb25vLk1lc3NhZ2VNYW5hZ2VyLlNlbmRNZXNzYWdlIHN0cmluZzomcXVvdDt4eHh4eHgm
cXVvdDsgc3RyaW5nOiZxdW90O2hlbGxvJnF1b3Q7b18wwqA8L2Rpdj48ZGl2Pm1ldGhvZCByZXR1
cm4gc2VuZGVyPToxLjIyIC0mZ3Q7IGRlc3Q9OjEuMzMgcmVwbHlfc2VyaWFsPTI8L2Rpdj48ZGl2
PsKgIMKgb2JqZWN0IHBhdGggJnF1b3Q7L2dlbWFsdG9fMC9tZXNzYWdlXzlCRDc3RkZENjk1RUIy
RjIzNEIyNTUyNTdDMUEzNzJEMkM0NTgyRjkmcXVvdDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkhlcmUgaSBtb25pdG9yIG9uIGFkZGVkICZxdW90O3Ntc1N0YXR1c1Vw
ZGF0ZSZxdW90OyBtZW1iZXIgZm9yIGFkZGVkIGludGVyZmFjZSAmcXVvdDtvcmcub2Zvbm8uc21z
SGlzdG9yeSZxdW90O8KgIMKgKDxiPmRidXMtbW9uaXRvciAtLXN5c3RlbSAmcXVvdDt0eXBlPSYj
Mzk7c2lnbmFsJiMzOTssaW50ZXJmYWNlPSYjMzk7b3JnLm9mb25vLnNtc0hpc3RvcnkmIzM5OyZx
dW90O8KgICZhbXA7IDwvYj4pPC9kaXY+PGRpdj7CoDwvZGl2PjwvZGl2PjxibG9ja3F1b3RlIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggNDBweDtib3JkZXI6bm9uZTtwYWRkaW5nOjBweCI+PGRp
dj48ZGl2Pn4jIHNpZ25hbCBzZW5kZXI9OjEuMjIgLSZndDsgZGVzdD0obnVsbCBkZXN0aW5hdGlv
bikgc2VyaWFsPTE2NTEgcGF0aD0vZ2VtYWx0b18wOyBpbnRlcmZhY2U9b3JnLm9mb25vLnNtc0hp
c3Rvcnk7IG1lbWJlcj1zbXNTdGF0dXNlPC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgYXJyYXkg
WzwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCBkaWN0IGVudHJ5KDwvZGl2PjwvZGl2Pjxk
aXY+PGRpdj7CoCDCoCDCoCDCoCDCoHN0cmluZyAmcXVvdDtTbXNJZCZxdW90OzwvZGl2PjwvZGl2
PjxkaXY+PGRpdj7CoCDCoCDCoCDCoCDCoHZhcmlhbnTCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmlu
ZyAmcXVvdDs5QkQ3N0ZGRDY5NUVCMkYyMzRCMjU1MjU3QzFBMzcyRDJDNDU4MkY5JnF1b3Q7PC9k
aXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgICk8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAg
wqAgZGljdCBlbnRyeSg8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqBzdHJpbmcg
JnF1b3Q7U3RhdHVzJnF1b3Q7PC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIMKgIMKgdmFy
aWFudMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDE2IDHCoCDCoCDCoCDCoCDCoCDCoCDCoD0mZ3Q7
IE9GT05PX0hJU1RPUllfU01TX1NUQVRVU19TVUJNSVRURUQ8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+
wqAgwqAgwqAgKTwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoF08L2Rpdj48L2Rpdj48ZGl2Pjxk
aXY+c2lnbmFsIHNlbmRlcj06MS4yMiAtJmd0OyBkZXN0PShudWxsIGRlc3RpbmF0aW9uKSBzZXJp
YWw9MTY1NSBwYXRoPS9nZW1hbHRvXzA7IGludGVyZmFjZT1vcmcub2Zvbm8uc21zSGlzdG9yeTsg
bWVtYmVyPXNtc1N0YXR1c1VwZGF0ZTwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoGFycmF5IFs8
L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgZGljdCBlbnRyeSg8L2Rpdj48L2Rpdj48ZGl2
PjxkaXY+wqAgwqAgwqAgwqAgwqBzdHJpbmcgJnF1b3Q7U21zSWQmcXVvdDs8L2Rpdj48L2Rpdj48
ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqB2YXJpYW50wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJpbmcg
JnF1b3Q7OUJENzdGRkQ2OTVFQjJGMjM0QjI1NTI1N0MxQTM3MkQyQzQ1ODJGOSZxdW90OzwvZGl2
PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCApPC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKg
IGRpY3QgZW50cnkoPC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIMKgIMKgc3RyaW5nICZx
dW90O1N0YXR1cyZxdW90OzwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCDCoCDCoHZhcmlh
bnTCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQxNiA0wqAgwqAgwqAgwqAgPSZndDsgT0ZPTk9fSElT
VE9SWV9TTVNfU1RBVFVTX0RFTElWRVJFRDwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCAp
PC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgXTwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2
IGRpcj0ibHRyIj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxiPkhlcmUgd2hl
biB1c2luZyB3cm9uZyBudW1iZXIgOsKgPC9iPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxi
bG9ja3F1b3RlIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggNDBweDtib3JkZXI6bm9uZTtwYWRk
aW5nOjBweCI+PGRpdj48ZGl2PiMgc2lnbmFsIHNlbmRlcj06MS4yMiAtJmd0OyBkZXN0PShudWxs
IGRlc3RpbmF0aW9uKSBzZXJpYWw9MjMzNyBwYXRoPS9nZW1hbHRvXzA7IGludGVyZmFjZT1vcmcu
b2Zvbm8uc21zSGlzdG9yeTsgbWVtYmVyPXNtc1N0YXR1c1VwZGF0ZTwvZGl2PjwvZGl2PjxkaXY+
PGRpdj7CoCDCoGFycmF5IFs8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgZGljdCBlbnRy
eSg8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqBzdHJpbmcgJnF1b3Q7U21zSWQm
cXVvdDs8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqB2YXJpYW50wqAgwqAgwqAg
wqAgwqAgwqAgwqBzdHJpbmcgJnF1b3Q7NjNEM0M5MDNCNUVFRDdCNDFEM0U2NjZDQTUzQTMyMDBE
NUUxNEYyMyZxdW90OzwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCApPC9kaXY+PC9kaXY+
PGRpdj48ZGl2PsKgIMKgIMKgIGRpY3QgZW50cnkoPC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKg
IMKgIMKgIMKgc3RyaW5nICZxdW90O1N0YXR1cyZxdW90OzwvZGl2PjwvZGl2PjxkaXY+PGRpdj7C
oCDCoCDCoCDCoCDCoHZhcmlhbnTCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQxNiAxPC9kaXY+PC9k
aXY+PGRpdj48ZGl2PsKgIMKgIMKgICk8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqBdPC9kaXY+
PC9kaXY+PGRpdj48ZGl2PnNpZ25hbCBzZW5kZXI9OjEuMjIgLSZndDsgZGVzdD0obnVsbCBkZXN0
aW5hdGlvbikgc2VyaWFsPTIzNDEgcGF0aD0vZ2VtYWx0b18wOyBpbnRlcmZhY2U9b3JnLm9mb25v
LnNtc0hpc3Rvcnk7IG1lbWJlcj1zbXNTdGF0dXNVcGRhdGU8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+
wqAgwqBhcnJheSBbPC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIGRpY3QgZW50cnkoPC9k
aXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIMKgIMKgc3RyaW5nICZxdW90O1Ntc0lkJnF1b3Q7
PC9kaXY+PC9kaXY+PGRpdj48ZGl2PsKgIMKgIMKgIMKgIMKgdmFyaWFudMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3RyaW5nICZxdW90OzYzRDNDOTAzQjVFRUQ3QjQxRDNFNjY2Q0E1M0EzMjAwRDVFMTRG
MjMmcXVvdDs8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAgwqAgKTwvZGl2PjwvZGl2PjxkaXY+
PGRpdj7CoCDCoCDCoCBkaWN0IGVudHJ5KDwvZGl2PjwvZGl2PjxkaXY+PGRpdj7CoCDCoCDCoCDC
oCDCoHN0cmluZyAmcXVvdDtTdGF0dXMmcXVvdDs8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqAg
wqAgwqAgwqB2YXJpYW50wqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MTYgNcKgIMKgPSZndDsgT0ZP
Tk9fSElTVE9SWV9TTVNfU1RBVFVTX0RFTElWRVJfRkFJTEVEPC9kaXY+PC9kaXY+PGRpdj48ZGl2
PsKgIMKgIMKgICk8L2Rpdj48L2Rpdj48ZGl2PjxkaXY+wqAgwqBdPC9kaXY+PC9kaXY+PC9ibG9j
a3F1b3RlPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGJyPjwvZGl2PjxkaXY+UGxlYXNlIGxldCBtZSBr
bm93IHlvdXIgb3BpbmlvbiBhbmQgc3VnZ2VzdGlvbnMuwqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PktpbmQgUmVnYXJkcyw8L2Rpdj48ZGl2PldhamRpIFpBSVJJPC9kaXY+PGRpdj5FbWJlZGRl
ZCBTb2Z0d2FyZSBFbmdpbmVlcjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkxlwqBqZXUu
IDE0IGbDqXZyLiAyMDE5IMOgwqAxODowNywgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IGEgw6ljcml0
wqA6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBXYWpkaSw8YnI+Cjxicj4KT24gMDIvMTQvMjAxOSAwNDo0
OSBBTSwgd2FqZGkgemFpcmkgd3JvdGU6PGJyPgomZ3Q7IEhpIGFsbCAsPGJyPgomZ3Q7IDxicj4K
Jmd0OyA8YnI+CiZndDsgV2UgYXJlIHBsYW5uaW5nIHRvIGFkZCBhIGZlYXR1cmUgdG8gaGFuZGxl
IHNlbnQgU01TIHN0YXR1cyAuIFRoZSA8YnI+CiZndDsgYXZhaWxhYmxlIE9GT05PIEFQSXMgdG8g
dXNlIHNlZW1zIHByb3ZpZGVkIGJ5ICpvcmcub2Zvbm8uTWVzc2FnZSrCoGJ1dCA8YnI+CiZndDsg
d2hlbiBpIG1hZGUgc29tZSB0ZXN0czxicj4KJmd0OyB0byBjYXRjaCB0aGUgKlByb3BlcnR5Q2hh
bmdlZCrCoHNpZ25hbCBvbiBhIHNlbnTCoFNNUyBpIG5vdGVzIHRoYXQgdGhlIDxicj4KJmd0OyBy
ZXN1bHQgaXMgYWx3YXlzICZxdW90O3NlbnQmcXVvdDsgKHdoZW4gb3V0IGZyb20gVFgpIGV2ZW4g
b24gYSB3cm9uZyBkZXN0aW5hdGlvbiA8YnI+CiZndDsgbnVtYmVyIC48YnI+CiZndDsgPGJyPgo8
YnI+CkNhbiB5b3UgZWxhYm9yYXRlP8KgIElmIHRoZSBkZXN0aW5hdGlvbiBudW1iZXIgaXMgc3Rp
bGwgYSB2YWxpZCBudW1iZXIsIDxicj4KdGhlbiB0aGlzIHdvdWxkbiYjMzk7dCBiZSBzdXJwcmlz
aW5nLjxicj4KPGJyPgomZ3Q7ICMgc2lnbmFsIHNlbmRlcj06MS4xMiAtJmd0OyBkZXN0PShudWxs
IGRlc3RpbmF0aW9uKSBzZXJpYWw9MTA1IDxicj4KJmd0OyBwYXRoPS9nZW1hbHRvXzAvbWVzc2Fn
ZV8yRjM0MjZFQUM1RTNFQkEzNjVGQTYyNjM0Nzg4NkMwRUM0REM1MzIzOyA8YnI+CiZndDsgaW50
ZXJmYWNlPW9yZy5vZm9uZDxicj4KJmd0O8KgIMKgIMKgc3RyaW5nICZxdW90O1N0YXRlJnF1b3Q7
PGJyPgomZ3Q7wqAgwqAgwqB2YXJpYW50wqAgwqAgwqAgwqBzdHJpbmcgJnF1b3Q7c2VudCZxdW90
Ozxicj4KJmd0OyA8YnI+CiZndDsgQWxzbyB0aGUgY2FsbCBvZiAqb3JnLm9mb25vLk1lc3NhZ2Uu
R2V0UHJvcGVydGllcyooKSBvbiBnaXZlbiBtZXNzYWdlIDxicj4KJmd0OyBvYmplY3QgcGF0aCB3
aWxsIGZhaWwgc2luY2Ugb2Zvbm8gaXMgcmVtb3ZpbmcgdG8gb2JqZWN0IGFmdGVyIHNlbmRpbmcg
PGJyPgomZ3Q7IChzbXNfdHhfcXVldWVfcmVtb3ZlX2VudHJ5KSAuPGJyPgo8YnI+ClllcywgdGhp
cyBpcyBleHBlY3RlZCBiZWhhdmlvciBhbmQgc29tZXdoYXQgZG9jdW1lbnRlZCBpbiB0aGUgPGJy
PgptZXNzYWdlbWFuYWdlci1hcGkudHh0LsKgIEhvd2V2ZXIsIEQtQnVzIEFQSSBpcyBub3QgbWVh
bnQgdG8gYmUgdXNlZCBmb3IgPGJyPgp0cmFja2luZyBtZXNzYWdlIGhpc3Rvcnk7IGluIGZhY3Qg
ZGVsaXZlcnkgcmVwb3J0cyBhcmUgbm90IGV2ZW4gc2lnbmFsZWQgPGJyPgp2aWEgRC1CdXMuwqAg
VGhpcyBpcyBvbiBwdXJwb3NlLCBzaW5jZSB3ZSBjYW5ub3QgZWFzaWx5IGd1YXJhbnRlZSBhbnkg
PGJyPgpzb3J0IG9mIHJlbGlhYmlsaXR5IHZpYSBhbnkgSVBDIG1lY2hhbmlzbSwgYW5kIGltcGxl
bWVudGluZyBhIHByb3RvY29sIDxicj4KYmV0d2VlbiBhIGhpc3RvcnkgY2xpZW50ICh1c2luZyBh
Y2tzIG9yIG90aGVyIG1lY2hhbmlzbXMpIG92ZXIgRC1CdXMgd2FzIDxicj4KZGVlbWVkIHRvIGJl
IHRvbyBjb21wbGljYXRlZC7CoCBUaGUgaGlzdG9yeSBwbHVnaW4gaXMgcHJvYmFibHkgd2hhdCB5
b3Ugd2FudC48YnI+Cjxicj4KJmd0OyA8YnI+CiZndDsgU28gaGVyZSB0aGUgJnF1b3Q7c2VudCZx
dW90OyBtZWFucyB0aGF0IHRoZSBtZXNzYWdlIHdhcyB0cmVhdGVkIGFuZCBvdXQgZnJvbSBUWCA8
YnI+CiZndDsgYnV0IGRvZXMgbm90IGdpdmUgdGhlIHJlYWwgc3RhdGUgaWYgaXQgd2FzIGRlbGl2
ZXJlZCBvciBub3QgLjxicj4KJmd0OyBJIG1hZGUgYSB0cnkgYnkgYWRkaW5nIEhpc3RvcnkgZHJp
dmVyIHRvIG91ciBHZW1hbHRvIGRyaXZlcnMgYW5kIGl0IDxicj4KJmd0OyBnaXZlcyBhIGJldHRl
ciByZXN1bHQgcmVnYXJkaW5nIFNNUyBkZWxpdmVyeSBzdGF0dXMgd2hpY2ggbWVldCBvdXIgPGJy
PgomZ3Q7IHJlcXVpcmVtZW50cy48YnI+Cjxicj4KSSYjMzk7bSBndWVzc2luZyB1c2luZyBzdGF0
dXMgcmVwb3J0cz88YnI+Cjxicj4KJmd0OyA8YnI+CiZndDsgVG8ga2VlcCBvdXIgb2Zvbm8gYWxp
Z25lZCB3aXRoIGxhdGVzdCBvZm9ubyB1cGRhdGVzLCB3ZSB3YW50IHRvIHVwc3RyZWFtIDxicj4K
Jmd0OyBvdXIgY29udHJpYnV0aW9ucyBzbyBpIHdhbnQgdG8gZ2V0IHlvdXIgb3BpbmlvbiBhYm91
dCBhIHByb3Bhc2FsIDxicj4KJmd0OyB1cHN0cmVhbSBjYW5kaWRhdGUgOjxicj4KJmd0OyA8YnI+
CiZndDsgLSBBZGQgaGlzdG9yeSBkcml2ZXIgaW1wbGVtZW50YXRpb24gdG8gZHJpdmVycy9nZW1h
bHRvbW9kZW1zLzxicj4KPGJyPgpXaHkgd291bGQgU01TIGhpc3RvcnkgYmUgc3BlY2lmaWMgdG8g
R2VtYWx0byBtb2RlbXM/PGJyPgo8YnI+CiZndDsgLSBBZGQgc2lnbmFsIGluIHBsdWdpbnMvZ2Vt
YWx0by5jwqAgdG8gbm90aWZ5IHRoZSBkaWZmZXJlbnQgc2VudCBtZXNzYWdlcyA8YnI+CiZndDsg
c3RhdHVzwqAgKGluZGljYXRlZCBvbiBlbnVtKm9mb25vX2hpc3Rvcnlfc21zX3N0YXR1cyrCoCk8
YnI+CiZndDsgLSBUaGVuIHRoZSBzaWduYWwgY2FuIGJlIGNvbnN1bWVkIGJ5IGFueSBjbGllbnQg
YWZ0ZXLCoHNlbmRpbmcgYW4gU01TIC48YnI+CiZndDsgPGJyPgo8YnI+ClRoZSByZWFzb24gd2h5
IHdlIGRvbiYjMzk7dCBoYXZlIHN1Y2ggYW4gQVBJIGlzIGFscmVhZHkgY292ZXJlZCBhYm92ZS4g
PGJyPgpJZGVhbGx5LCB5b3Ugd2FudCB0aGUgaGlzdG9yeSBwbHVnaW4gdG8gZGlyZWN0bHkgdXBk
YXRlIHRoZSBoaXN0b3J5IGluIDxicj4KeW91ciBkYXRhYmFzZSBvZiBjaG9pY2UsIG9yIHNpbXBs
eSBjYWxsIHlvdXIgY2FsbC9zbXMgaGlzdG9yeSB0cmFja2luZyA8YnI+CnNlcnZpY2UgZGlyZWN0
bHkuwqAgVGhlcmUmIzM5O3MgcmVhbGx5IG5vIHJlYXNvbiB0byBicm9hZGNhc3QgdGhpcyA8YnI+
CmluZm9ybWF0aW9uIHZpYSBhIGRpZmZlcmVudCBBUEkuPGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgot
RGVuaXM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============0186672978953104584==--

