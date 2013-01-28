Content-Type: multipart/mixed; boundary="===============6874023961986683087=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 5/9] bluez5: Add bt_getsockpeers()
Date: Mon, 28 Jan 2013 13:34:34 -0300
Message-ID: <CAKT1EBdjfAxp7-uBrxNEr-rFp_WFSXcKrKzx=d=u+zDzGythEQ@mail.gmail.com>
In-Reply-To: <1359387137.16748.30.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6874023961986683087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

On Mon, Jan 28, 2013 at 12:32 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> Hi Claudio,
>
>> This patch adds a generic Bluetooth helper function to allow getting
>> the adapter and device Bluetooth Address from Bluetooth sockets.
>> ---
>>  plugins/bluez5.c | 22 ++++++++++++++++++++++
>>  plugins/bluez5.h |  3 +++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/plugins/bluez5.c b/plugins/bluez5.c
>> index d7e85f2..06629e1 100644
>> --- a/plugins/bluez5.c
>> +++ b/plugins/bluez5.c
>> @@ -52,6 +52,28 @@ int bt_ba2str(const bdaddr_t *ba, char *str)
>>               ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]=
);
>>  }
>>
>> +int bt_getsockpeers(int sock, struct sockaddr *src, struct sockaddr *ds=
t,
>> +                                                             socklen_t =
len)
>> +{
>
> I really do not get why this is helpful at all. Except for making the
> code less readable. So please do not do it. Call the socket functions
> directly from where they are used.
>
> In addition the name of this function is totally misleading. It does not
> describe at all what it does. The peer is always the remote address. You
> are not getting the src and dst peers here. That is not how the socket
> nomenclature works. It is either socket name for the local address or
> peer name for the remote address.
>
> Regards
>
> Marcel

Ok. I will remove this function. I added this function here because
other oFono Plugins will need a similar function.
We can add it later if we notice that it is really necessary.

Regards,
Claudio

--===============6874023961986683087==--

