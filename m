Content-Type: multipart/mixed; boundary="===============8777420573731013068=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] controbase: Add combobox for CBS scheme selection
Date: Fri, 22 Jun 2012 03:08:29 -0500
Message-ID: <4FE427FD.1040300@gmail.com>
In-Reply-To: <1340635083-5877-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8777420573731013068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> +<item row=3D"0" column=3D"3">
> +<widget class=3D"QComboBox" name=3D"cbScheme">
> +<property name=3D"currentIndex">
> +<number>0</number>
> +</property>
> +<item>
> +<property name=3D"text">
> +<string>Default GSM</string>
> +</property>
> +</item>
> +<item>
> +<property name=3D"text">
> +<string>UCS2</string>
> +</property>
> +</item>
> +</widget>
> +</item>

Since you're adding intelligence to figure out the 'best' encoding =

scheme anyway, are you sure these are actually needed?  The only reason =

to add this is if you have english characters but want to force encoding =

in UCS2.

Regards,
-Denis

--===============8777420573731013068==--

