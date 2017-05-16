Content-Type: multipart/mixed; boundary="===============2120672352856223674=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Tue, 16 May 2017 13:33:56 -0500
Message-ID: <c1064a32-f957-e01b-58bf-542b90895118@gmail.com>
In-Reply-To: <20170516152328.775cfd0d@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2120672352856223674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/16/2017 11:14 AM, Alexander Couzens wrote:
> Hi,
>
> as it get's quite exhausting to create over and over qmi messages by
> hand, I'm wondered why ofono isn't using a library for it.
> Is there a reason why ofono isn't using libqmi [1] or the .json [2] to
> generate code like other projects does [3]?
>

libqmi is quite large, depends on weird glib features and is really not =

an option for us.  Furthermore, we will eventually be migrating away =

from glib, so introducing additional dependencies or libraries that =

depend on glib will just make our life harder in the future.

When we started our QMI driver, libqmi was still in its early stages. =

Much of the work understanding the protocol still had to be done by =

hand.  Back then we decided that auto-generating the code wasn't =

worthwhile.  It is almost certain that there will not be multiple QMI =

based drivers.  So by the time you wrote the JSON definition or =

equivalent, you could have implemented the driver method that used it.

Regards,
-Denis

--===============2120672352856223674==--

