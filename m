Content-Type: multipart/mixed; boundary="===============6922264594682806081=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: Need Clarification on DCS handling in Status Report for SMS
Date: Wed, 01 Dec 2010 18:03:13 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A7C0@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A79D@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6922264594682806081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

> In the decode SMS function, there is a check to find out if =

> there is a PI (parameter identifier). If there is a PI and no =

> DCS flag set, then the ofono core sets the dcs to default. If =

> the PI itself is missing in the PDU received from the =

> network, then the dcs values are not set to default.
> =

> This seems to cause a problem, where, the decoding of dcs =

> fails, and results in not sending the delivery notification =

> to clients.

Yes, this is a bug. But rather than setting the DCS to default in
this case, we should rather not call that sms_dcs_decode() function
from ofono_sms_status_notify(), as the class information derived from
the DCS decoding is not used there and also we are not handling the
optional text information in the status report handling currently.

If we decide to handle this optional text information (most likely not
going to happen), then some modifications are required.

Also there is another bug in the current code which might not be
relevant
if we decide to remove the sms_dcs_decode() function call from
ofono_sms_status_notify(). In that function call instead of passing
s.status_report.dcs, we are currently passing s.deliver.dcs.

BR,
Rajesh

--===============6922264594682806081==--

