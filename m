Content-Type: multipart/mixed; boundary="===============6760127098866117004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Mon, 04 Jan 2016 10:18:57 -0600
Message-ID: <568A9B71.7080208@gmail.com>
In-Reply-To: <CADnUhn1iurv551=GeaJpP23Jscpu9GDtcybPSZ4tTePrvS-NNA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6760127098866117004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

 > -------------------------
> usbserial:
> --------------------------
> usbserial: USB Serial support registered for GSM modem (1-port)
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB0
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB1
> usb 2-1: GSM modem (1-port) converter now attached to ttyUSB2
>

Are you sure the ttys are handled by the 'usbserial' module and not =

'option'?  If they really are, then you might need to update =

plugins/udevng.c appropriately.

Right now I see the following in the vendor_list[] table:
         { "huawei",     "option",       "201e"          },
         { "huawei",     "cdc_wdm",      "12d1"          },
         { "huawei",     "cdc_ether",    "12d1"          },
         { "huawei",     "qmi_wwan",     "12d1"          },
         { "huawei",     "option",       "12d1"          },

You probably also need to add an entry for cdc_ncm.  See the recent =

patch adding similar support for mbm:
git show b04fabcda34b6433209bacab32b78a95b1c11b3e

I'd start with adding the cdc_ncm entry to vendor_list[] table and see =

if that makes things work.

Regards,
-Denis

--===============6760127098866117004==--

