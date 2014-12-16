Content-Type: multipart/mixed; boundary="===============5316270433494575173=="
MIME-Version: 1.0
From: vicamo@gmail.com
Subject: Re: "IPv6.Settings" in interface "org.ofono.ConnectionContext" is not
 a valid name
Date: Tue, 16 Dec 2014 13:40:02 +0800
Message-ID: <CAJ-KqdwqvLfULBSuiJg5nvaoowAVWid+c74PyD35feihZcxs-g@mail.gmail.com>
In-Reply-To: <548FBF41.3030806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5316270433494575173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the quick correction. I did find this problem when trying to
generate interface binding code by gdbus-codegen from gio. It generates
functions with a period character in their names which are certainly not
valid c function names.

Vicamo


2014-12-16 13:12 GMT+08:00 Denis Kenzior <denkenz@gmail.com>:
>
> Hi,
>
>
> On 12/15/2014 09:57 PM, vicamo(a)gmail.com wrote:
>
>> Hi all,
>>
>> I happen to find a strange property "IPv6.Settings" in
>> ConnectionContext. According to DBus specification [1], dbus member
>> names can only be consisted of character set "[A-Z][a-z][0-9]_" and may
>> not begin with a digit. Any plan to get rid of it? Or is a patch to this
>> welcomed? It will certainly break compatibility to existing programs.
>>
>> [1]:
>> http://dbus.freedesktop.org/doc/dbus-specification.html#
>> message-protocol-names
>>
>>
> Properties are not member names, so the restrictions you mention do not
> apply.  See the DBus Specification:
>
> "Strictly speaking, D-Bus property names are not required to follow the
> same naming restrictions as member names, but D-Bus property names that
> would not be valid member names (in particular, GObject-style
> dash-separated property names) can cause interoperability problems and
> should be avoided. "
>
> Since the oFono DBus API is currently frozen, there are no plans on
> "fixing" this particular property.
>
> Regards,
> -Denis
>

--===============5316270433494575173==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpLDxicj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3Ug
Zm9yIHRoZSBxdWljayBjb3JyZWN0aW9uLiBJIGRpZCBmaW5kIHRoaXMgcHJvYmxlbSB3aGVuIHRy
eWluZyB0byBnZW5lcmF0ZSBpbnRlcmZhY2UgYmluZGluZyBjb2RlIGJ5IGdkYnVzLWNvZGVnZW4g
ZnJvbSBnaW8uIEl0IGdlbmVyYXRlcyBmdW5jdGlvbnMgd2l0aCBhIHBlcmlvZCBjaGFyYWN0ZXIg
aW4gdGhlaXIgbmFtZXMgd2hpY2ggYXJlIGNlcnRhaW5seSBub3QgdmFsaWQgYyBmdW5jdGlvbiBu
YW1lcy48YnI+PGJyPjwvZGl2PjxkaXY+VmljYW1vPGJyPjxicj48L2Rpdj48L2Rpdj48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE0
LTEyLTE2IDEzOjEyIEdNVCswODowMCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+SGksPGRpdj48ZGl2IGNsYXNzPSJoNSI+PGJyPgo8YnI+Ck9uIDEyLzE1
LzIwMTQgMDk6NTcgUE0sIDxhIGhyZWY9Im1haWx0bzp2aWNhbW9AZ21haWwuY29tIiB0YXJnZXQ9
Il9ibGFuayI+dmljYW1vQGdtYWlsLmNvbTwvYT4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGkgYWxsLDxicj4KPGJyPgpJIGhhcHBlbiB0
byBmaW5kIGEgc3RyYW5nZSBwcm9wZXJ0eSAmcXVvdDtJUHY2LlNldHRpbmdzJnF1b3Q7IGluPGJy
PgpDb25uZWN0aW9uQ29udGV4dC4gQWNjb3JkaW5nIHRvIERCdXMgc3BlY2lmaWNhdGlvbiBbMV0s
IGRidXMgbWVtYmVyPGJyPgpuYW1lcyBjYW4gb25seSBiZSBjb25zaXN0ZWQgb2YgY2hhcmFjdGVy
IHNldCAmcXVvdDtbQS1aXVthLXpdWzAtOV1fJnF1b3Q7IGFuZCBtYXk8YnI+Cm5vdCBiZWdpbiB3
aXRoIGEgZGlnaXQuIEFueSBwbGFuIHRvIGdldCByaWQgb2YgaXQ/IE9yIGlzIGEgcGF0Y2ggdG8g
dGhpczxicj4Kd2VsY29tZWQ/IEl0IHdpbGwgY2VydGFpbmx5IGJyZWFrIGNvbXBhdGliaWxpdHkg
dG8gZXhpc3RpbmcgcHJvZ3JhbXMuPGJyPgo8YnI+ClsxXTo8YnI+CjxhIGhyZWY9Imh0dHA6Ly9k
YnVzLmZyZWVkZXNrdG9wLm9yZy9kb2MvZGJ1cy1zcGVjaWZpY2F0aW9uLmh0bWwjbWVzc2FnZS1w
cm90b2NvbC1uYW1lcyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9kYnVzLmZyZWVkZXNrdG9wLm9y
Zy88dT48L3U+ZG9jL2RidXMtc3BlY2lmaWNhdGlvbi5odG1sIzx1PjwvdT5tZXNzYWdlLXByb3Rv
Y29sLW5hbWVzPC9hPjxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj48L2Rpdj4KUHJv
cGVydGllcyBhcmUgbm90IG1lbWJlciBuYW1lcywgc28gdGhlIHJlc3RyaWN0aW9ucyB5b3UgbWVu
dGlvbiBkbyBub3QgYXBwbHkuwqAgU2VlIHRoZSBEQnVzIFNwZWNpZmljYXRpb246PGJyPgo8YnI+
CiZxdW90O1N0cmljdGx5IHNwZWFraW5nLCBELUJ1cyBwcm9wZXJ0eSBuYW1lcyBhcmUgbm90IHJl
cXVpcmVkIHRvIGZvbGxvdyB0aGUgc2FtZSBuYW1pbmcgcmVzdHJpY3Rpb25zIGFzIG1lbWJlciBu
YW1lcywgYnV0IEQtQnVzIHByb3BlcnR5IG5hbWVzIHRoYXQgd291bGQgbm90IGJlIHZhbGlkIG1l
bWJlciBuYW1lcyAoaW4gcGFydGljdWxhciwgR09iamVjdC1zdHlsZSBkYXNoLXNlcGFyYXRlZCBw
cm9wZXJ0eSBuYW1lcykgY2FuIGNhdXNlIGludGVyb3BlcmFiaWxpdHkgcHJvYmxlbXMgYW5kIHNo
b3VsZCBiZSBhdm9pZGVkLiAmcXVvdDs8YnI+Cjxicj4KU2luY2UgdGhlIG9Gb25vIERCdXMgQVBJ
IGlzIGN1cnJlbnRseSBmcm96ZW4sIHRoZXJlIGFyZSBubyBwbGFucyBvbiAmcXVvdDtmaXhpbmcm
cXVvdDsgdGhpcyBwYXJ0aWN1bGFyIHByb3BlcnR5Ljxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURl
bmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+Cg==

--===============5316270433494575173==--

