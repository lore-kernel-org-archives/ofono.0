Content-Type: multipart/mixed; boundary="===============3278623134940252736=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Thu, 26 Sep 2019 20:09:57 -0500
Message-ID: <b03847fa-9f4c-7e7b-422e-7086fe2aace1@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB6557C@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3278623134940252736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 9/26/19 4:46 AM, Borwankar, Antara wrote:
> Hi Denis,
> =

> Regarding your below query
> =

> - Can you tell me why this new addition uses vid/pid with a 0x prefix whi=
le the rest of the table does not?  It seems weird & inconsistent.
> Actually in case of pci device vendor and device id read using libudev AP=
I is returning as "0x8086" and "0x7560" strings respectively. So I have add=
ed the same values in vendor_list table.

That is strange.  Okay, so maybe we should just add a different look-up =

table to handle this.  Perhaps pci_driver_list[] and use vids/pids with =

0x prefixes there.

> In case of usb device the vendor and device strings returned by same libu=
dev API does not have "0x" prefix. I don=E2=80=99t have any idea why it is =
so.
> =

> If you insist I can remove this prefix 0x from vendor_list table and chan=
ge the implementation of check_pci_device() function to handle comparison o=
f vendor and model strings with vid, pid form vendor_list.

Yep, that might be another alternative.  I'd be fine with either. =

Having some entries with 0x and some without will confuse people and =

lead to bugs.

Regards,
-Denis

--===============3278623134940252736==--

