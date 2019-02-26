Content-Type: multipart/mixed; boundary="===============8264113698893906919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono vs modemmanager
Date: Tue, 26 Feb 2019 17:50:19 -0600
Message-ID: <da3e2dab-ea03-8b60-1bb4-10c2a40205c5@gmail.com>
In-Reply-To: <CAA=hcWQ3PiP3b0M2LDQDC_SSf88xSts0J8p75JuQos=7nZ+p5w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8264113698893906919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

On 02/25/2019 04:43 PM, JH wrote:
> Hi,
> =

> I am new to ofono, we used to use modemmanager for 3G/4G modem in a
> tiny embedded Linux device, I tried to search Internet for the
> differences between ofono and modemmanager, but I could not find any.
> What is the appealing reason I can justify to use ofnono over
> modemmanager? Is it because connman?
> =


A comprehensive answer would be fairly long-winded, so here's my attempt =

at a short(er) one:

The two projects are related, and there is a lot of overlap between the =

two.  However, they each focused on different aspects of the ecosystem. =

ModemManager was mostly about making WWAN broadband work for laptops, =

desktops and other devices.  Since it has been traditionally well =

integrated with NetworkManager, it has a large install base.  It has =

good support for various WWAN devices, arguably better than oFono in =

this regard.

On the flip side, oFono was driven mostly by embedded phone use cases. =

So it is/was much more focused on being a traditional telephony stack =

and includes features like fully-featured voice call state machine, =

multiple active PDP contexts, SIM filesystem reading/updating, SMS =

(including various regional SMS language dialects), Supplementary =

Services, Sim Toolkit, MMI code parsing, USSDs, and general =

certification aspects.  oFono based devices have been certified / =

pre-certified multiple times by GCF and there were (are?) still =

companies selling phones with oFono (or variant thereof) as the =

telephony stack.  I have not followed ModemManager development closely =

in some time, so some of these may also now be available there as well.

So it sort of depends on your needs as to which project is more =

suitable.  If you need to make a device that makes voice calls and has a =

built-in modem, oFono is likely better suited to your needs.  If you =

need to support a wide variety of devices (e.g. furnished by end-user) =

and all you care about is WWAN broadband, then ModemManager probably has =

an edge.

Perform your own due diligence and compare features side-by-side.

Regards,
-Denis

--===============8264113698893906919==--

