Content-Type: multipart/mixed; boundary="===============3456977360987409256=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 2/3] network: Add CPHS SPN, short-SPN fallbacks
Date: Mon, 19 Dec 2011 14:58:33 +0200
Message-ID: <4EEF34F9.9050503@intel.com>
In-Reply-To: <4EEBE831.8030701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3456977360987409256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 12/17/2011 02:54 AM, Denis Kenzior wrote:
> I went ahead and applied this patch, but modified it heavily afterward.
>   Can you please check the changes starting at 7f18695f and make sure
> that things are still working as intended and I didn't screw anything up.

Everything works as expected, thanks for the help!

I just wonder now about the case when the SPN update would happen while the =

NETWORK_REGISTRATION_FLAG_READING_SPN is on.

diff --git a/src/network.c b/src/network.c
struct ofono_netreg {
[...]
         char *spn;
+       unsigned int spn_update;
  };
[...]

+static gboolean spn_update_cb(gpointer userdata)
+{
+       struct ofono_netreg *netreg =3D userdata;
+
+       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
+               return TRUE;
+
+       netreg->spn_update =3D 0;
+
+       sim_spn_changed(0, netreg);
+
+       return FALSE;
+}
+
  static void sim_spn_changed(int id, void *userdata)
  {
         struct ofono_netreg *netreg =3D userdata;
         gboolean had_spn;

-       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN)
+       if (netreg->flags & NETWORK_REGISTRATION_FLAG_READING_SPN) {
+               if (netreg->spn_update =3D=3D 0)
+                       netreg->spn_update =3D g_timeout_add(1000,
+                                                       spn_update_cb, netr=
eg);
+
                 return;
+       }
[...]

What do you think?

I will be sending SPN changes for src/gprs.c soon.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============3456977360987409256==--

