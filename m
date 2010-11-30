Content-Type: multipart/mixed; boundary="===============8525245072016611304=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [ofono] vendor code
Date: Tue, 30 Nov 2010 06:22:29 -0600
Message-ID: <4CF4EC85.9050003@gmail.com>
In-Reply-To: <AANLkTimcBqdNK=ZLnc=8nReMujJDxc5UfmRKMiOU4A6m@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8525245072016611304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

On 11/30/2010 04:45 AM, Tonny Tzeng wrote:
> Hi List,
> =

> While debugging a connection issue using huawei EM770W modem, I added
> a DBG code to print out the status value received in at_cgreg_cb() in
> drivers/atmodem/gprs.c, I found the status got from the
> at_util_parse_reg() is incorrect sometimes, because ofono does not set
> vendor ID in the gprs_data, and it looks to me the vendor code is
> required so that the at_util_parse_reg() will read unquoted strings in
> the solicited events for huawei modem.  For example, when we got
> "+CGREG: 1, 2833, 1231B60" followed by "+CGREG: 2,1, 2733, 1B60"
> unsolicited codes, the status parsed from this code is 2833 (i.e. the
> 1st code), instead of the expected 1 in the 2nd code.
> =


I suggest you complain to the vendor that they do not follow standards,
and ask them to fix their firmware.

> It looks like all modem plugins invoke ofono_gprs_context_create()
> with vendor=3D0, is this on purpose?  then how could at_util_parse_reg()
> parses strings correctly without knowing vendor code?

This can be added to the huawei driver, however this won't help you
completely as the firmware still reports bizarre values.  Care to send a
patch?

Regards,
-Denis

--===============8525245072016611304==--

