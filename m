Content-Type: multipart/mixed; boundary="===============2583320014107582862=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: Re: [ofono] vendor code
Date: Wed, 01 Dec 2010 10:15:48 +0800
Message-ID: <AANLkTimd=Q+4pwJAuBMtePYGOg6dCPU13THrp1_yA+EX@mail.gmail.com>
In-Reply-To: <4CF4EC85.9050003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2583320014107582862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On Tue, Nov 30, 2010 at 8:22 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>> While debugging a connection issue using huawei EM770W modem, I added
>> a DBG code to print out the status value received in at_cgreg_cb() in
>> drivers/atmodem/gprs.c, I found the status got from the
>> at_util_parse_reg() is incorrect sometimes, because ofono does not set
>> vendor ID in the gprs_data, and it looks to me the vendor code is
>> required so that the at_util_parse_reg() will read unquoted strings in
>> the solicited events for huawei modem. =C2=A0For example, when we got
>> "+CGREG: 1, 2833, 1231B60" followed by "+CGREG: 2,1, 2733, 1B60"
>> unsolicited codes, the status parsed from this code is 2833 (i.e. the
>> 1st code), instead of the expected 1 in the 2nd code.
>
> I suggest you complain to the vendor that they do not follow standards,
> and ask them to fix their firmware.

Any possibility that this is a race condition?  Just while ofono
sending AT+CGREG? to poll the CGREG state, modem already sent out
unsolicited CGREG?  I saw at_util_parse_reg() also tries to skip
unsolicited CREG/CGREG, so it looks like this is valid concern?

>> It looks like all modem plugins invoke ofono_gprs_context_create()
>> with vendor=3D0, is this on purpose? =C2=A0then how could at_util_parse_=
reg()
>> parses strings correctly without knowing vendor code?
>
> This can be added to the huawei driver, however this won't help you
> completely as the firmware still reports bizarre values. =C2=A0Care to se=
nd a
> patch?

Sure I will patch and send out the huawei plugins patch, but since I
am not familiar with the overall ofono code, so I'd like to verify
what my understanding so far -- modem plugins should send the vendor
ID while invoke ofono_gprs_context_create()?  Would you please
confirm?  Thanks.

>
> Regards,
> -Denis
>

--===============2583320014107582862==--

