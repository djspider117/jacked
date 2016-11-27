using UnityEngine;
using System.Collections;

public class GravityBend : MonoBehaviour
{
    private float _curTime;

    // Use this for initialization
    void Start()
    {
        //var rbd = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        _curTime += Time.fixedDeltaTime;
        if (_curTime >= 1)
        {
            
            Physics.gravity = new Vector3(Random.Range(-9.8f, 9.8f), Random.Range(-9.8f, 9.8f), Random.Range(-9.8f, 9.8f));
            _curTime = 0;
        }

    }
}
