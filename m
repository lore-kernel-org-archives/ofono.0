Content-Type: multipart/mixed; boundary="===============7976229513648457082=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: ofono vs modemmanager
Date: Wed, 27 Feb 2019 11:41:20 +1100
Message-ID: <CAA=hcWRQ_q1X9ypkeF_6iCjjVLsnc8GTTT7ujLoUxsLrHrrgNw@mail.gmail.com>
In-Reply-To: <da3e2dab-ea03-8b60-1bb4-10c2a40205c5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7976229513648457082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2/27/19, Denis Kenzior <denkenz@gmail.com> wrote:

> The two projects are related, and there is a lot of overlap between the
> two.  However, they each focused on different aspects of the ecosystem.
> ModemManager was mostly about making WWAN broadband work for laptops,
> desktops and other devices.  Since it has been traditionally well
> integrated with NetworkManager, it has a large install base.  It has
> good support for various WWAN devices, arguably better than oFono in
> this regard.

I am not using WWAN and it is an embedded Linux using WiFi (client and
AP) and LTE, the NM is too large to be installed in Linux embedded
system, I'll use ConnMan instead. It'll make sense to use oFono.

> On the flip side, oFono was driven mostly by embedded phone use cases.
> So it is/was much more focused on being a traditional telephony stack
> and includes features like fully-featured voice call state machine,
> multiple active PDP contexts, SIM filesystem reading/updating, SMS
> (including various regional SMS language dialects), Supplementary
> Services, Sim Toolkit, MMI code parsing, USSDs, and general
> certification aspects.  oFono based devices have been certified /
> pre-certified multiple times by GCF and there were (are?) still
> companies selling phones with oFono (or variant thereof) as the
> telephony stack.  I have not followed ModemManager development closely
> in some time, so some of these may also now be available there as well.

The device is for data communication either via WiFi or LTE, SIM
reading / updating is definitely needed. The application is programmed
in C++, I think SIM reading / updating and other set up funcations can
be done via C API, is it right place to learn the oFono C API from the
test program in tools directory?

> So it sort of depends on your needs as to which project is more
> suitable.  If you need to make a device that makes voice calls and has a
> built-in modem, oFono is likely better suited to your needs.  If you
> need to support a wide variety of devices (e.g. furnished by end-user)
> and all you care about is WWAN broadband, then ModemManager probably has
> an edge.

Both WiFi/BLE modem and LTE modem is built in the hardware, the main
functions are to set up WiFi client and AP and set up LTE both likely
to be implemented via C API in program, and to switch network
interfaces between LTE and WiFi very much like the mobile phone except
it is stationary much simpler, LTE is the default connection, when the
WiFi is available, switching to WiFi automatically. I believe ConnMan
can do the network interface automatically.

> Perform your own due diligence and compare features side-by-side.

Thanks for you advice, I've already decided to use oFono, I am going
to learn, to build, to install the oFono.

Thank you very much Denis

Kind regards,

- jupiter

--===============7976229513648457082==--

