Content-Type: multipart/mixed; boundary="===============4631298130377238775=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH 1/2] smsutil: sms_decode() allow to pass sms with unknown
 TPDU size
Date: Wed, 17 May 2017 01:01:18 +0200
Message-ID: <20170517010118.4157374e@lazus.yip>
In-Reply-To: <42f4d13e-d2c2-bbdd-b268-f9cbbe09c245@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4631298130377238775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Alexander,
> =

> On 05/16/2017 10:49 AM, Alexander Couzens wrote:
> > Certain modems (QMI based) only return a PDU length, but without
> > the length of the TPDU.  =

> =

> It looks like the current QMI_WMS_RESULT_NEW_MSG_NOTIFY assumes that
> the message doesn't have an SMSC preceeding it.  Or is it that we are
> not parsing some other parameters?

The nice thing here is:
When receiving a SMS PDU over the notify callback, it doesn't contain a
SC address, but when reading it from NV it does.

> > Without passing this information over ofono_sms_deliver_notify()
> > down to sms_decode(), sms_decode() will fail, as it try to
> > interpret the SC header as PDU header.  =

> =

> How do we know when a PDU contains the SC address and when it doesn't?
I don't know. Sorry, I didn't read (yet) the whole spec. =


Originally I though it would be possible and a good idea to detect SC,
but sms_decode_address_field() can exit early with success and
sms_decode() fail later when decoding. A second pass is then required.
I dropped that idea and use fixed expectation, hopefully QMI behave the
same way on different devices.

> [..]

> > b) export sms_decode_address_field() which is part of smsutil.h
> > would mean using this function only to get the length of TPDU and
> > throw away the result (address), which is later called a second
> > time.  =

> =

> In-tree drivers can freely utilize core utilities such as smsutil and =

> stkutil.  So this isn't really a problem.  Since the QMI API is quite =

> dumb, then parsing the SC address field twice is probably the least
> evil way to do this.

Ok. Will do it that way.

-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============4631298130377238775==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxrYmhMNEFDZ2tRd3A2ZHBxRGYKaGdRckdBLy9hZEFmeHBwTzVw
RTI4RitYNFFIQURvcE56UFUwYnByUzNzZ0ljMjc0Q1VYa1dVYWxRc0FTbjZjcApPUFdOQmErbHlE
MjAyd1FwbC9HWXdMdWFlRkNOQWtWRWU2WnZ6c0E1ZEV2eVBkV29TTlRXZkVINWVLb0kwUk8rCit0
RXBaWU1JeTIxTStIeExNUWVOVmwxQzYzT0JnYVFQaW1WdjBpM2s2Z21jNmRiZHZmaWN1YjBKQmJG
UnZKTC8KelRFRGlqM3RBY3FsYnl0MkZhWjlUUm4xVkVBVTFPY0dhQXdiUkdxOFVWUFNRY21qZy93
V1BpZFVpV3FyTFpQZQpSTmhSWm1aenpFZFFwTUNtV0tUVmovSXFOYXBTaEZkWHJZRVlOaFNGM1Rm
VW1RZDkzbm9NUkpZSlcyZ1Jzd0ZxCkNQN3kvTGhsTC9vNmYrWmN5clgyWmRpT0tkODFlM1RrNWsr
SlhQdU1GY0NnZGlZVS8yQU9EcTRyZVg2eXgraW4KeGxYNllBdW8wY0NZakl0WUNXbnhWalJwUm9m
bitMRm9WWlV5ZlAxUGdzSXhqcmprNkRkcGZHNGZzNUYwV0l6MQpUV0lWMUxHVDBoYVBwZWdZaEpC
V2tndklpNys1QnRMRVo3a0xIZWZqWkljeVVwT3dBckJJM3VCUUljYlA2R04zCnRwZU1IUFhPbGpT
L3RpS1laUjZIaUtzdVI5SmFuUk44bVRzYmRCTExaTlRnN0lVc0c4dFczQXlSWTlUeVc2YjkKU2Ex
ZnRDNHFHOWwyOTcxK1YwOEl0WW0wSzJJeUhNZXVnSFZQNDAra3M5aDJqUUhBN1A4RWpaOFhLTE9o
dmZYNgo4THdvbFFQM1RDWFMxOHVidkN0YWJHUXZpY3lpZ21zMUxhSFNDVTR4azJRUnM1VXZaSFk9
Cj1TcjFWCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============4631298130377238775==--

