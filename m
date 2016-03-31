Content-Type: multipart/mixed; boundary="===============4404272668065720606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] test: Add get serving cell information script
Date: Thu, 31 Mar 2016 10:07:17 -0500
Message-ID: <56FD3D25.80604@gmail.com>
In-Reply-To: <1459398303-5978-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4404272668065720606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On 03/30/2016 11:25 PM, Nishanth V wrote:
> ---
>   Makefile.am                |  3 ++-
>   test/get-serving-cell-info | 56 +++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 58 insertions(+), 1 deletion(-)
>   create mode 100644 test/get-serving-cell-info
>

I went ahead and applied this one, but...

> diff --git a/Makefile.am b/Makefile.am
> index ce4c107..5cd9766 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -744,7 +744,8 @@ test_scripts =3D test/backtrace \
>   		test/register-auto \
>   		test/register-operator \
>   		test/set-sms-smsc \
> -		test/set-sms-bearer
> +		test/set-sms-bearer \
> +		test/get-serving-cell-info
>
>   if TEST
>   testdir =3D $(pkglibdir)/test
> diff --git a/test/get-serving-cell-info b/test/get-serving-cell-info
> new file mode 100644
> index 0000000..05dc9fe
> --- /dev/null
> +++ b/test/get-serving-cell-info
> @@ -0,0 +1,56 @@
> +#!/usr/bin/python3
> +
> +import dbus
> +
> +bus =3D dbus.SystemBus()
> +
> +manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.=
Manager')
> +
> +modems =3D manager.GetModems()
> +path =3D modems[0][0]
> +

Can you please add some way to select the modem to use?  Many developers =

run multiple modems (e.g. phonesim, stktest + real hardware ones), so =

scripts assuming that the first modem is the target is inconvenient.

See test/set-sms-bearer that Anirudh did for an example. Or test/send-sms

> +monitor =3D dbus.Interface(bus.get_object('org.ofono', path),
> +						'org.ofono.NetworkMonitor')
> +
> +try:
> +	servingcell =3D monitor.GetServingCellInformation()
> +except dbus.DBusException as e:
> +	print("Unable to get serving cell information")
> +	exit()
> +
> +tech =3D 'Technology'
> +mcc =3D 'MobileCountryCode'
> +mnc =3D 'MobileNetworkCode'
> +lac =3D 'LocationAreaCode'
> +cid =3D 'CellId'
> +psc =3D 'PrimaryScramblingCode'
> +rssi =3D 'Strength'
> +ber =3D 'BitErrorRate'
> +
> +print("Current serving cell information:")
> +
> +if tech in servingcell:
> +	print("    [ Radio Access Technology =3D %s]" % (servingcell[tech]))
> +
> +if mcc in servingcell:
> +	print("    [ Mobile Country Code =3D %s]" % (servingcell[mcc]))
> +
> +if mnc in servingcell:
> +	print("    [ Mobile Network Code =3D %s]" % (servingcell[mnc]))
> +
> +if lac in servingcell:
> +	print("    [ Location Area Code =3D %d]" % (servingcell[lac]))
> +
> +if cid in servingcell:
> +	print("    [ Cell Identity =3D %d]" % (servingcell[cid]))
> +
> +if psc in servingcell:
> +	print("    [ Primary Scrambling Code =3D %d]" % (servingcell[psc]))
> +
> +if rssi in servingcell:
> +	print("    [ Signal Strength =3D %d]" % (servingcell[rssi]))
> +
> +if ber in servingcell:
> +	print("    [ Bit Error Rate =3D %d]" % (servingcell[ber]))
> +
> +print('')
>

Regards,
-Denis

--===============4404272668065720606==--

