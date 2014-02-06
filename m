Content-Type: multipart/mixed; boundary="===============8839352879435758478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to connect Huawei HiLink E303
Date: Thu, 06 Feb 2014 11:17:31 -0600
Message-ID: <52F3C3AB.7030608@gmail.com>
In-Reply-To: <CAK+sfovfw-jxkgfYKA4sqURwmJV3AwGQKy_yiKO6cWhNq0a4sQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8839352879435758478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Homam,

On 02/06/2014 11:20 AM, Homam Dabis wrote:
> I don't think it is anything to do with the APN as I can connect with
> the network-manager with out disconnecting the modem or replacing the sim.
>

That really doesn't mean anything.

> ofonod[18701]: Modem: > AT+CGDCONT=3D1,"IP","3ireland.ie"\r

Is the APN correct?

> ofonod[18701]: Modem: < \r\nOK\r\n
> ofonod[18701]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod[18701]: Modem: > AT+CGDATA=3D"PPP",1\r
> ofonod[18701]: Modem: < \r\n+CME ERROR: 50\r\n
> ofonod[18701]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
> ofonod[18701]: Unable to enter data state
> ofonod[18701]: src/gprs.c:pri_activate_callback() 0x22f5900
> ofonod[18701]: src/gprs.c:pri_activate_callback() Activating context
> failed with error: Incorrect parameters

If the APN is correct, as a quick hack try changing:

                 gc =3D ofono_gprs_context_create(modem, 0,
                                                 "atmodem", data->modem);

in plugins/huawei.c huawei_post_sim() to

                 gc =3D ofono_gprs_context_create(modem,
					OFONO_VENDOR_SIMCOM_SIM900,
                                         "atmodem", data->modem);

Regards,
-Denis

--===============8839352879435758478==--

