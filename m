Content-Type: multipart/mixed; boundary="===============3277328897805613757=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Need Clarification on DCS handling in Status Report for SMS
Date: Thu, 02 Dec 2010 07:57:58 -0600
Message-ID: <4CF7A5E6.5080703@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A7C0@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3277328897805613757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

> =

> Yes, this is a bug. But rather than setting the DCS to default in
> this case, we should rather not call that sms_dcs_decode() function
> from ofono_sms_status_notify(), as the class information derived from
> the DCS decoding is not used there and also we are not handling the
> optional text information in the status report handling currently.

It is still a bug that should be fixed ;)

> =

> If we decide to handle this optional text information (most likely not
> going to happen), then some modifications are required.
> =

> Also there is another bug in the current code which might not be
> relevant
> if we decide to remove the sms_dcs_decode() function call from
> ofono_sms_status_notify(). In that function call instead of passing
> s.status_report.dcs, we are currently passing s.deliver.dcs.

That is a good catch.  We should actually check the DCS to filter out
any malformed status reports.

Anyway, both issues should now be fixed with commits:
c5a42cfabe3abe0d99299daffbe04c33a217fb25
ac72349017fbfdecbba000c0259cc6b99f0873ed

Please test and report back whether the issues persist.

Regards,
-Denis

--===============3277328897805613757==--

