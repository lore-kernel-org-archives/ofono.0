Content-Type: multipart/mixed; boundary="===============1040139850788863977=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: status
Date: Thu, 27 Sep 2018 11:52:16 -0500
Message-ID: <aa0f22dd-bf16-1f57-a4fc-a9b7261dbc2b@gmail.com>
In-Reply-To: <CAKSBH7EF1K2mr-dgtRvnP3-8b2-PLuGHVmGvudd62kLyN1BBkA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1040139850788863977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> For the gemaltomodem/gprs-context, it is not clear how to proceed. Would
> you kindly give some suggestion other than "these modules don't exist in =

> my world"?

I did give you a suggestion on how to proceed.  Lets get the sane ones =

supported first.  That should be mostly easy.

For the insane ones we will need to figure something else out.  For =

example, it may be that we should just have oFono initiate the DHCP =

request itself for these devices.  The driver can then control both DHCP =

and context activation status and would be able to sanely tell the core =

what is going on.  We already have DHCP code available in ConnMan that =

could be ported to oFono, or more likely finish DHCP support in ell and =

use that.

Maybe there are simpler / better approaches that could be tried as well. =

  But the current proposal for these insane devices is just not going to =

work.

Regards,
-Denis

--===============1040139850788863977==--

