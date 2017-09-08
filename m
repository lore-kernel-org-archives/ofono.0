Content-Type: multipart/mixed; boundary="===============1614214938210492700=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/6] qmimodem: extract network time from serving system
Date: Fri, 08 Sep 2017 11:33:48 +0200
Message-ID: <fdff8f32-54a9-6d2c-7f96-732c2af9aa70@southpole.se>
In-Reply-To: <158bbb77-3391-316c-98e6-ba22f9737c0e@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1614214938210492700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 10:48 AM, Jonas Bonn wrote:
>
> I tested this and didn't get any time info... I'm not sure these are =

> always sent by default but might need to be enabled with the 'Register =

> Indications' method (NAS method 0x03)...

I tested this.  'Register Indications' is not necessarily the right way =

forward as that has nothing to do with the 'serving system' indication.  =

I'm not getting the Time parameters on the Serving System indication, in =

any case.

/Jonas

--===============1614214938210492700==--

