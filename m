Content-Type: multipart/mixed; boundary="===============6812771474969158511=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 09:02:38 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A247234@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1292577039.29886.56.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6812771474969158511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi,
> =

> I have investigated a little bit dynamic updating of emergency numbers
> by network. So I suggest, I'll register new notification-handler for
> '+CEN'-report in voicecall-driver. And naturally give those new
> emergency-numbers for voicecall-atom to be analyzed.

The modem will typically already analyze the new emergency-numbers, filter =
out the ones that are not applicable and merge the numbers from the various=
 sources in the right priority. Some modems are able to communicate the res=
ulting effective list of emergency-numbers, in which case the voicecall-ato=
m should just use the list of emergency numbers reported by the modem witho=
ut doing any additional merging/analyzing.

This also eliminates room for error if the algorithm that the ofono voiceca=
ll atom uses differs for some reason from the algorithm used by the modem.

For modems that aren't able to communicate their effective list of emergenc=
y numbers ofono would still need to create such list by itself as it does n=
ow.

Cheers,
Waldo

--===============6812771474969158511==--

