Content-Type: multipart/mixed; boundary="===============3337470597483966021=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 00/30] QMI rework
Date: Wed, 28 Mar 2018 16:51:40 -0500
Message-ID: <3ff1fc64-7169-bc32-b4ba-de7ca1af796d@gmail.com>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3337470597483966021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> =

> So, that said, this is my attempt at cleaning up service sharing in the
> QMI core.  The jist of this is that we switch to a model that looks a
> bit like file descriptions/descriptors in Linux.  The QMI services
> obtain a service description which manages their info and the underlying
> connection (client id) state that the 'shared services' actually share.

So can you save me the trouble of looking through 30 patches and =

describe what the end resulting API is going to look like?

> On top of this service description we provide service descriptors which
> provide private state.  Requests and notifications are registered on the
> service descriptor and their lifetimes are tied to it; when the service
> descriptor is closed (released), the requests and notifications can be
> cleaned up without affecting other users of the shared unlying
> description.
> =


This sounds an awful lot like what GAtChat does.  Except less flexible =

since you can't unregister or cancel an individual notification/request.

Regards,
-Denis

--===============3337470597483966021==--

