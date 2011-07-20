Content-Type: multipart/mixed; boundary="===============9133073439610238260=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/4] cdma-connman: add possibility to set a username and a
 password
Date: Wed, 20 Jul 2011 12:10:10 +0200
Message-ID: <4E26A982.4090704@linux.intel.com>
In-Reply-To: <1311155307.21109.190.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9133073439610238260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 20/07/2011 11:48, Marcel Holtmann wrote:
> Hi Guillaume,
>
>>   src/cdma-connman.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 43 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/cdma-connman.c b/src/cdma-connman.c
>> index 3321b87..7ca5a0a 100644
>> --- a/src/cdma-connman.c
>> +++ b/src/cdma-connman.c
>> @@ -57,6 +57,8 @@ struct ofono_cdma_connman {
>>   	const struct ofono_cdma_connman_driver *driver;
>>   	void *driver_data;
>>   	struct ofono_atom *atom;
>> +	char *username;
>> +	char *password;
>>   };
> I am still not convinced that this is needed. Please provide logs where
> it shows that it fails otherwise.

You will find attached an ofono log giving the result in harcoding,
g_at_ppp_set_credentials(cd->ppp, "", ""); before launching PPP session.


>
>>   static void cdma_connman_settings_free(struct cdma_connman_settings *s=
ettings)
>> @@ -379,6 +381,8 @@ static DBusMessage *cdma_connman_set_property(DBusCo=
nnection *conn,
>>   	DBusMessageIter var;
>>   	const char *property;
>>   	dbus_bool_t value;
>> +	const char *username;
>> +	const char *password;
>>
>>   	DBG("");
>>
>> @@ -399,7 +403,7 @@ static DBusMessage *cdma_connman_set_property(DBusCo=
nnection *conn,
>>
>>   	dbus_message_iter_recurse(&iter,&var);
>>
>> -	if (!strcmp(property, "Powered")) {
>> +	if (!g_strcmp0(property, "Powered")) {
> Don't bother here. strcmp is just fine since we know both arguments are
> not NULL.
>
> Also if you wanna change this, then please have a separate patch for it.
> Intermixing of code with style changes is not a good idea. And we have
> always fixed style issues separately.

Ok, I will keep strcmp() fro username and password also, and I will =

commit g_strcmp0() later if needed.

>>   		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
>>   			return __ofono_error_invalid_args(msg);
>>
>> @@ -421,6 +425,22 @@ static DBusMessage *cdma_connman_set_property(DBusC=
onnection *conn,
>>   			cm->driver->deactivate(cm, deactivate_callback, cm);
>>
>>   		return dbus_message_new_method_return(msg);
>> +	} else if (!g_strcmp0(property, "Username")) {
>> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
>> +			return __ofono_error_invalid_args(msg);
>> +
>> +		dbus_message_iter_get_basic(&var,&username);
>> +		cm->username =3D g_strdup(username);
>> +		DBG("username: %s", username);
>> +		return dbus_message_new_method_return(msg);
>> +	} else if (!g_strcmp0(property, "Password")) {
>> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
>> +			return __ofono_error_invalid_args(msg);
>> +
>> +		dbus_message_iter_get_basic(&var,&password);
>> +		cm->password =3D g_strdup(password);
>> +		DBG("password: %s", password);
>> +		return dbus_message_new_method_return(msg);
>>   	}
>>
>>   	/* TODO: Dormant property. Not yet supported. */
>> @@ -488,6 +508,12 @@ static void cdma_connman_remove(struct ofono_atom *=
atom)
>>   	if (cm->driver&&  cm->driver->remove)
>>   		cm->driver->remove(cm);
>>
>> +	if (cm->username)
>> +		g_free(cm->username);
>> +
>> +	if (cm->password)
>> +		g_free(cm->password);
>> +
> The if check are pointless. g_free (and also free for that matter) does
> a NULL check on its parameter.
>

Right, I forgot about this null check...

>> @@ -568,3 +594,19 @@ void *ofono_cdma_connman_get_data(struct ofono_cdma=
_connman *cm)
>>   {
>>   	return cm->driver_data;
>>   }
>> +
>> +const char *ofono_cdma_connman_get_username(struct ofono_cdma_connman *=
cm)
>> +{
>> +	if (cm->username)
>> +		return cm->username;
>> +
>> +	return NULL;
>> +}
>> +
>> +const char *ofono_cdma_connman_get_password(struct ofono_cdma_connman *=
cm)
>> +{
>> +	if (cm->password)
>> +		return cm->password;
>> +
>> +	return NULL;
>> +}
> What is wrong with just "return cm->password;". This example is a bit
> convoluted right now ;)
>
> The next question is where you want the NULL handling. Or do you want it
> all. Please think about that a little bit and maybe have a look at what
> GPRS is doing.
>

Ok

Kind regards,
Guillaume

--===============9133073439610238260==
Content-Type: text/x-log
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ofono-cdma.log"

b2Zvbm9kWzg3MzVdOiBwbHVnaW5zL3NwZWVkdXBjZG1hLmM6c3BlZWR1cGNkbWFfZW5hYmxlKCkg
cGF0aCBpczogL2Rldi90dHlVU0IwCm9mb25vZFs4NzM1XTogTW9kZW06ID4gQVRFMCArQ01FRT0x
XHIKb2Zvbm9kWzg3MzVdOiBwbHVnaW5zL2JsdWV0b290aC5jOm1hbmFnZXJfcHJvcGVydGllc19j
YigpIApvZm9ub2RbODczNV06IHBsdWdpbnMvYmx1ZXRvb3RoLmM6cGFyc2VfYWRhcHRlcnMoKSAK
b2Zvbm9kWzg3MzVdOiBwbHVnaW5zL2JsdWV0b290aC5jOnBhcnNlX2FkYXB0ZXJzKCkgQ2FsbGlu
ZyBHZXRQcm9wZXJ0aWVzIG9uIC9vcmcvYmx1ZXovMTQ2MS9oY2kwCm9mb25vZFs4NzM1XTogcGx1
Z2lucy9ibHVldG9vdGguYzphZGFwdGVyX3Byb3BlcnRpZXNfY2IoKSAKb2Zvbm9kWzg3MzVdOiBw
bHVnaW5zL2JsdWV0b290aC5jOnBhcnNlX2RldmljZXMoKSAKb2Zvbm9kWzg3MzVdOiBwbHVnaW5z
L2JsdWV0b290aC5jOmFkYXB0ZXJfcHJvcGVydGllc19jYigpIEFkYXB0ZXIgQWRkcmVzczogNUM6
QUM6NEM6RkY6MEM6MDUsIFBhdGg6IC9vcmcvYmx1ZXovMTQ2MS9oY2kwCm9mb25vZFs4NzM1XTog
TW9kZW06IDwgXHJcbk9LXHJcbgpvZm9ub2RbODczNV06IE1vZGVtOiA+IEFUK0NGVU49MVxyCm9m
b25vZFs4NzM1XTogTW9kZW06IDwgXHJcbk9LXHJcbgpvZm9ub2RbODczNV06IHBsdWdpbnMvc3Bl
ZWR1cGNkbWEuYzpjZnVuX2VuYWJsZSgpIApvZm9ub2RbODczNV06IHNyYy9tb2RlbS5jOm1vZGVt
X2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMCwgbmV3IHN0YXRlOiAxCm9mb25vZFs4NzM1XTog
cGx1Z2lucy9zcGVlZHVwY2RtYS5jOnNwZWVkdXBjZG1hX3ByZV9zaW0oKSAweDg1ZjcxNzAKb2Zv
bm9kWzg3MzVdOiBzcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDEs
IG5ldyBzdGF0ZTogMgpvZm9ub2RbODczNV06IHBsdWdpbnMvc3BlZWR1cGNkbWEuYzpzcGVlZHVw
Y2RtYV9wb3N0X3NpbSgpIDB4ODVmNzE3MApvZm9ub2RbODczNV06IHNyYy9tb2RlbS5jOm1vZGVt
X2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMiwgbmV3IHN0YXRlOiAzCm9mb25vZFs4NzM1XTog
cGx1Z2lucy9zcGVlZHVwY2RtYS5jOnNwZWVkdXBjZG1hX3Bvc3Rfb25saW5lKCkgMHg4NWY3MTcw
Cm9mb25vZFs4NzM1XTogc3JjL2NkbWEtY29ubm1hbi5jOm9mb25vX2NkbWFfY29ubm1hbl9jcmVh
dGUoKSAKb2Zvbm9kWzg3MzVdOiBkcml2ZXJzL2NkbWFtb2RlbS9jb25ubWFuLmM6Y2RtYV9jb25u
bWFuX3Byb2JlKCkgCm9mb25vZFs4NzM1XTogTW9kZW06ID4gQVQmQzBccgpvZm9ub2RbODczNV06
IE1vZGVtOiA8IFxyXG5PS1xyXG4Kb2Zvbm9kWzg3MzVdOiBkcml2ZXJzL2NkbWFtb2RlbS9jb25u
bWFuLmM6YXRfYzBfY2IoKSBvayAxCm9mb25vZFs4NzM1XTogc3JjL2NkbWEtY29ubm1hbi5jOm9m
b25vX2NkbWFfY29ubm1hbl9yZWdpc3RlcigpIApvZm9ub2RbODczNV06IE1vZGVtOiA+IEFUK0dN
SVxyCm9mb25vZFs4NzM1XTogTW9kZW06IDwgXHJcbk1hbnVmYWN0dXJlclxyXG5cclxuT0tcclxu
Cm9mb25vZFs4NzM1XTogTW9kZW06ID4gQVQrR01NXHIKb2Zvbm9kWzg3MzVdOiBNb2RlbTogPCBc
clxuRVZETyBVU0IgTU9ERU1cclxuXHJcbk9LXHJcbgpvZm9ub2RbODczNV06IE1vZGVtOiA+IEFU
K0dNUlxyCm9mb25vZFs4NzM1XTogTW9kZW06IDwgXHJcbkxDQTAwMTcuMS4xX00wMzRcclxuXHJc
bk9LXHJcbgpvZm9ub2RbODczNV06IE1vZGVtOiA+IEFUK0dTTlxyCm9mb25vZFs4NzM1XTogTW9k
ZW06IDwgXHJcbjB4OTA0QkMzMjVcclxuXHJcbk9LXHJcbgpvZm9ub2RbODczNV06IHNyYy9jZG1h
LWNvbm5tYW4uYzpjZG1hX2Nvbm5tYW5fc2V0X3Byb3BlcnR5KCkgCm9mb25vZFs4NzM1XTogZHJp
dmVycy9jZG1hbW9kZW0vY29ubm1hbi5jOmNkbWFfY29ubm1hbl9hY3RpdmF0ZSgpIApvZm9ub2Rb
ODczNV06IE1vZGVtOiA+IEFURCM3NzdccgpvZm9ub2RbODczNV06IE1vZGVtOiA8IFxyXG5DT05O
RUNUIDMxMDAwMDBcclxuCm9mb25vZFs4NzM1XTogZHJpdmVycy9jZG1hbW9kZW0vY29ubm1hbi5j
OmF0ZF9jYigpIG9rIDEKb2Zvbm9kWzg3MzVdOiBkcml2ZXJzL2NkbWFtb2RlbS9jb25ubWFuLmM6
c2V0dXBfcHBwKCkgCm9mb25vZFs4NzM1XTogZHJpdmVycy9jZG1hbW9kZW0vY29ubm1hbi5jOnBw
cF9kaXNjb25uZWN0KCkgCm9mb25vZFs4NzM1XTogc3JjL2NkbWEtY29ubm1hbi5jOmFjdGl2YXRl
X2NhbGxiYWNrKCkgMHg4NWYyY2E4IChudWxsKQpvZm9ub2RbODczNV06IHNyYy9jZG1hLWNvbm5t
YW4uYzphY3RpdmF0ZV9jYWxsYmFjaygpIEFjdGl2YXRpbmcgcGFja2V0IGRhdGEgc2VydmljZSBm
YWlsZWQgd2l0aCBlcnJvcjogVW5rbm93biBlcnJvciB0eXBlCgo=

--===============9133073439610238260==--

