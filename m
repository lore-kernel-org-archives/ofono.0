Content-Type: multipart/mixed; boundary="===============4665517044161515396=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Query related to UDUB for voice calls.
Date: Mon, 04 Oct 2010 07:16:52 -0500
Message-ID: <4CA9C5B4.4070705@gmail.com>
In-Reply-To: <AANLkTikyjKjkx_j=ug_yEoC2=W+OpsKG23Dr9PYf5f04@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4665517044161515396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

This is your final reminder about not top-posting on this list.  All
further Emails like this will be ignored.

On 10/04/2010 01:58 AM, Sankar wrote:
> HI Denis,
> =

> Thanks for the response. I feel like due to the limitation of the AT
> modem interface through 27007, we are missing the basic functionality
> defined in the other specifications for UDUB.
> Please comment.

What limitation? If I hang up an incoming call I expect it to go to
voice mail.  Why would you want to do it any other way?

oFono has to work with both AT and non-AT command modems, without
becoming overly complicated.  This means that the core has to assume
some behavior.  Since the only viable standard is 27.007, that is what
we stick to (even though some AT modem manufacturers don't)

However, in this particular case the behavior is the one that makes the
most sense to the user.  So I'm really not seeing your concern here...

Regards,
-Denis

--===============4665517044161515396==--

