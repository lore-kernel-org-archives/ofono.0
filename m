Content-Type: multipart/mixed; boundary="===============0822166130850062110=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: 4G LTE connection stability with USB voltage requirement
Date: Mon, 27 Jan 2020 13:26:41 +1100
Message-ID: <CAA=hcWTiqmULgD1JqEHUo4iXtrCt+zQAHmJL8=wPUNqPA57ENA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0822166130850062110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Apologies for cross posting.

I am running Yocto build image with kernel 4.19.75 on iMX6, the device
uses uBlox SARA-R4 4G LTE modem. I have an LTE connection stability
issue, it could connect to 4G LTE, then the connection was
disconnected between half an hour to an hour randomly, the error
messages were qmi_wwan of qmi_wwan 1-1:1.3: nonzero urb status
received: -71 and qmi_wwan 1-1:1.3: wdm_int_callback - usb_submit_urb
failed with result -19 for errors of EPROTO and ENODEV, many indicated
that kind of errors usually caused by insufficient USB voltage.

To diagnose it, I changed to use a DC regulated power supply to
connect USB voltage from a stable 5V DC regulated power supply, that
did help to stabilize the 4G LTE connection, the device has been
stable to connect to 4G LTE since yesterday (26 January AEST) morning
more than 24 hours which was not able to perform that stability if the
USB connected to a laptop or connected the device internal regulated
DC voltage from AC power supply.

What cannot convince to hardware engineers and what baffling me is
that I am also testing an image built from OpenWrt using network
manager netifd, it did not have LTE connection issue and it could
connect to 4G LTE much stable to use either USB power supply from a
laptop or device internal DC voltage from AC power supply. It does not
make sense if I say to the hardware engineer that device has power
supply issues. Why OpenWrt netifd is much stable than connman / ofono
in the same power supply conditions?

It seems to me there are subtle differences between connman / ofono
and OpenWrt netifd, could the connman / ofono require more rigid
stable USB voltage than OpenWrt netifd? Or could the OpenWrt netifd be
more superior than connman / ofono in terms of 4G LTE connections?

Appreciate your insight comments and advice.

Thank you.

Kind regards,

- jh
--===============0822166130850062110==--

