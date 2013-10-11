Content-Type: multipart/mixed; boundary="===============2282667049600461095=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins,
 mbpi: make mbpi return only APNs of a given type. When provisioning
 for internect connection,
 only OFONO_GPRS_CONTEXT_TYPE_INTERNET APNs will be returned.
Date: Fri, 11 Oct 2013 12:00:35 -0500
Message-ID: <52582EB3.2040004@gmail.com>
In-Reply-To: <CACM4vuCbfXX75-tq4mY6JOv1YJ_TXzxOXuPJH+HL6HOfZy2vSQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2282667049600461095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

No top posting on this mailing list please.

 > No problem with splitting the patch.
>
> The patch is related to the following bug:
>
> https://bugs.launchpad.net/ubuntu/+source/ofono/+bug/1222106
>
> So we were obtaining some times settings for the MMS APN instead of the
> internet one. Maybe the change makes it work only for internet
> connection, but not for MMS. Would that mean that get_settings() should
> have a parameter specifying the context type so the user decides?
>

The mbpi parser will assign a context type to the provisioned context =

based on the "type" attribute inside mobile-broadband-provider-info.  So =

assuming the parser is working correctly, the context will be labeled =

accordingly in oFono on the D-Bus API level.

The parser works by returning all contexts that match a particular =

mcc/mnc if and only if no conflicts or multiple matches are found. =

Since you're saying it picks the 'wrong' one, then I assume the issue is =

inside your application, not oFono.

What does test/list-contexts output look like when you run the =

provisioning procedure?

Regards,
-Denis

--===============2282667049600461095==--

