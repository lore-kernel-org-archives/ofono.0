Content-Type: multipart/mixed; boundary="===============9108710291738465029=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Sat, 17 Aug 2019 21:53:16 +1000
Message-ID: <CAA=hcWRjyHXDDxfuRJMbRZu3rvUshzpxR-Zi+ytVzODzYa-LZw@mail.gmail.com>
In-Reply-To: <62d7df6f-278b-cfbc-af5e-e4539d2f7e3b@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9108710291738465029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 8/16/19, Daniel Wagner <wagi@monom.org> wrote:
> The NTP code is just telling it can't reach the server. This has no
> direct connenction to the next entry.

So that from NTP, don't need to worry about it.

> This message is from the kernel via RTNL interface. The kernel tells
> ConnMan the interface state has changed.

OK, all from kernel, what could make the kernel to delete the link?


>> connmand[213]: Skipping disconnect of /ubloxqmi_0/context1, network is
>> connecting.
>> connmand[213]: ipconfig state 2 ipconfig method 1

> Your log does not contain the debug information (connmand -d).

I attached two log files running in debug, doesn't seem

$ OFONO_QMI_DEBUG=3D1 ofonod -d

$ connmand -d

--===============9108710291738465029==--

