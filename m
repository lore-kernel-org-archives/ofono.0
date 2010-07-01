Content-Type: multipart/mixed; boundary="===============1640408502153545377=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: How about offering a raw way for SMS
Date: Thu, 01 Jul 2010 11:52:34 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE8051011ED@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTikiCGSyn775gEHTejkdJNtcfTNZBe6N68ebm57n@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1640408502153545377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Ofono stack encodes SMS before send it.  User may need send some special
SMS. Such as send a v-card via SMS. =


It need to add user data header to indicate it is a v-card. Ofono
currently does not support this feature. How about =


offering an API for user to sending raw PDU directly?  such as:

         void SendRawMessage(string pdu)

So,  user can encode it by himself and send the PDU. It can also applied
to sending message with validity period/status report =


requirement and so on.

 =


Similarly,  how about sending out the raw PDU when dispatch incoming
message?  There are many kinds of

SMS, such as voice mail notification, MMS notification, push mail
notification etc.  How about sending out the raw =


PDU to upper layer and depending on upper layer to decode and decide how
to process it? =


 =


Thanks,

Caiwen








--===============1640408502153545377==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4KPEhUTUw+PEhFQUQ+PFRJVExFPjwvVElUTEU+CjxNRVRBIGh0dHAtZXF1aXY9Q29udGVu
dC1UeXBlIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11cy1hc2NpaSI+CjxNRVRBIGNvbnRl
bnQ9Ik1TSFRNTCA2LjAwLjI5MDAuNTk0NSIgbmFtZT1HRU5FUkFUT1I+PC9IRUFEPgo8Qk9EWT48
IS0tIENvbnZlcnRlZCBmcm9tIHRleHQvcGxhaW4gZm9ybWF0IC0tPgo8UD48Rk9OVCBzaXplPTI+
PEZPTlQgZmFjZT1DYWxpYnJpIHNpemU9Mz5IaSBhbGwsPC9GT05UPjwvRk9OVD48L1A+CjxQPjxG
T05UIHNpemU9Mj48Rk9OVCBmYWNlPUNhbGlicmkgc2l6ZT0zPk9mb25vIHN0YWNrIGVuY29kZXMg
U01TIGJlZm9yZSBzZW5kIAppdC4mbmJzcDsgVXNlciBtYXkgbmVlZCBzZW5kIHNvbWUgc3BlY2lh
bCBTTVMuIFN1Y2ggYXMgc2VuZCBhIHYtY2FyZCB2aWEgU01TLiAKPC9GT05UPjwvRk9OVD48L1A+
CjxQPjxGT05UIHNpemU9Mj48Rk9OVCBmYWNlPUNhbGlicmkgc2l6ZT0zPkl0IG5lZWQgdG8gYWRk
IHVzZXIgZGF0YSBoZWFkZXIgdG8gCmluZGljYXRlJm5ic3A7aXQgaXMgYSB2LWNhcmQuIE9mb25v
IDwvRk9OVD48L0ZPTlQ+PEZPTlQgZmFjZT1DYWxpYnJpPmN1cnJlbnRseSAKZG9lcyBub3Qgc3Vw
cG9ydCB0aGlzIGZlYXR1cmU8L0ZPTlQ+PEZPTlQgZmFjZT1DYWxpYnJpPi4gPC9GT05UPjxGT05U
IApzaXplPTI+PEZPTlQgZmFjZT1DYWxpYnJpIHNpemU9Mz5Ib3cgYWJvdXQgPC9GT05UPjwvRk9O
VD48L1A+CjxQPjxGT05UIHNpemU9Mj48Rk9OVCBmYWNlPUNhbGlicmkgc2l6ZT0zPm9mZmVyaW5n
IGFuIEFQSSBmb3IgdXNlciB0byBzZW5kaW5nIApyYXcgUERVIDwvRk9OVD48L0ZPTlQ+PEZPTlQg
c2l6ZT0yPjxGT05UIGZhY2U9Q2FsaWJyaSBzaXplPTM+ZGlyZWN0bHk/Jm5ic3A7IApzdWNoIGFz
OjwvRk9OVD48L0ZPTlQ+PC9QPgo8UD48Rk9OVCBzaXplPTI+PEZPTlQgZmFjZT1DYWxpYnJpIApz
aXplPTM+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7PEZPTlQgCmNvbG9yPSMwMDAwZmY+dm9pZCBTZW5kUmF3TWVzc2FnZShzdHJpbmcgcGR1KTwv
Rk9OVD48L0ZPTlQ+PC9GT05UPjwvUD4KPFA+PEZPTlQgc2l6ZT0yPjxGT05UIGZhY2U9Q2FsaWJy
aSBzaXplPTM+PEZPTlQgY29sb3I9IzAwMDBmZj48Rk9OVCAKY29sb3I9IzAwMDAwMD5TbywmbmJz
cDsgdXNlciBjYW4gZW5jb2RlIGl0IGJ5IGhpbXNlbGYgYW5kIHNlbmQgdGhlIFBEVS4gSXQgY2Fu
IAphbHNvIGFwcGxpZWQgdG8gc2VuZGluZyBtZXNzYWdlIHdpdGggdmFsaWRpdHkgcGVyaW9kL3N0
YXR1cyByZXBvcnQgCjwvRk9OVD48L0ZPTlQ+PC9GT05UPjwvRk9OVD48L1A+CjxQPjxGT05UIGZh
Y2U9Q2FsaWJyaT5yZXF1aXJlbWVudCBhbmQgc28gb24uPC9GT05UPjwvUD4KPFA+PEZPTlQgZmFj
ZT1DYWxpYnJpPjwvRk9OVD4mbmJzcDs8L1A+CjxQPjxGT05UIGZhY2U9Q2FsaWJyaT5TaW1pbGFy
bHksJm5ic3A7IGhvdyBhYm91dCBzZW5kaW5nIG91dCB0aGUgcmF3IFBEVSAKd2hlbiZuYnNwO2Rp
c3BhdGNoJm5ic3A7aW5jb21pbmcmbmJzcDttZXNzYWdlPyZuYnNwOyBUaGVyZSBhcmUgbWFueSBr
aW5kcyAKb2Y8L0ZPTlQ+PC9QPgo8UD48Rk9OVCBmYWNlPUNhbGlicmk+U01TLCBzdWNoIGFzIHZv
aWNlIG1haWwgbm90aWZpY2F0aW9uLCBNTVMgbm90aWZpY2F0aW9uLCAKcHVzaCBtYWlsIG5vdGlm
aWNhdGlvbiBldGMuJm5ic3A7IEhvdyBhYm91dCBzZW5kaW5nIG91dCB0aGUgcmF3IDwvRk9OVD48
L1A+CjxQPjxGT05UIGZhY2U9Q2FsaWJyaT5QRFUgdG8gdXBwZXIgbGF5ZXIgYW5kIGRlcGVuZGlu
ZyBvbiB1cHBlciBsYXllciB0byBkZWNvZGUgCmFuZCBkZWNpZGUgaG93IHRvIHByb2Nlc3MgaXQ/
IDwvRk9OVD48L1A+CjxQPjxGT05UIGZhY2U9Q2FsaWJyaT48L0ZPTlQ+Jm5ic3A7PC9QPgo8UD48
Rk9OVCBzaXplPTI+PEZPTlQgZmFjZT1DYWxpYnJpIHNpemU9Mz48Rk9OVCBjb2xvcj0jMDAwMGZm
PjxGT05UIApjb2xvcj0jMDAwMDAwPlRoYW5rcyw8L0ZPTlQ+PC9GT05UPjwvRk9OVD48L0ZPTlQ+
PC9QPgo8UD48Rk9OVCBzaXplPTI+PEZPTlQgZmFjZT1DYWxpYnJpIHNpemU9Mz48Rk9OVCBjb2xv
cj0jMDAwMGZmPjxGT05UIApjb2xvcj0jMDAwMDAwPkNhaXdlbjwvRk9OVD48QlI+PC9GT05UPjwv
Rk9OVD48QlI+PEJSPjxCUj48QlI+PEJSPjwvUD48L0ZPTlQ+PC9CT0RZPjwvSFRNTD4K

--===============1640408502153545377==--

