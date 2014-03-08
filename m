Content-Type: multipart/mixed; boundary="===============8495062558579755547=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Fri, 07 Mar 2014 21:37:09 -0600
Message-ID: <531A9065.4030009@gmail.com>
In-Reply-To: <531A6302.7060008@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8495062558579755547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

 >
> Actually though, I do have one question about the API being frozen.  Are
> there any plans to remove the OFONO_API_SUBJECT_TO_CHANGE pre-processor
> logic in plugins.h?

Nope.  The D-Bus API is frozen and we take that seriously.  The internal =

API will likely never be.

> We value the ofono project because it provides a solid, flexible
> framework for providing telephony services to Linux-based devices.

Thanks for the compliment :)

> As for operator examples, the apns-conf from a Galaxy Nexus (4.3?)
> includes five different APNs for ATT in the US ( mcc/mnc: 310/410 );
> this includes one APN for the MVNO Straightalk.  I have another newer
> version of apns-conf that has only two defined for the same operator.

This is where the UI that Marcel and I described comes in.  Ask the user =

which set he wants to use.  Programming in all bazillion contexts is =

pretty pointless.

> That said, even though the SPN is passed to the provisioning plugin, it
> doesn't appear to be used in the mbpi logic, nor the original version of
> the android_apndb code.

That's because MBPI doesn't have any SPN information, nor is it defined =

in the DTD last I checked.  MBPI can / should be improved quite a bit to =

make provisioning more fool proof.

Regards,
-Denis

--===============8495062558579755547==--

